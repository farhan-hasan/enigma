import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/model/firebase_where_model.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/chat_request/domain/dto/friendship_dto.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/accept_chat_request_usecase.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/fetch_chat_request_usecase.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/fetch_friends_usecase.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/fetch_pending_request_usecase.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/remove_friend_usecase.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/send_chat_request_usecase.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_generic.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/domain/usecases/read_all_people_usecase.dart';
import 'package:enigma/src/features/profile/presentation/view_model/controller/people_controller.dart';
import 'package:enigma/src/features/story/presentation/view_model/story_controller.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatRequestProvider =
    StateNotifierProvider<ChatRequestController, ChatRequestGeneric>(
        (ref) => ChatRequestController(ref));

class ChatRequestController extends StateNotifier<ChatRequestGeneric> {
  ChatRequestController(this.ref) : super(ChatRequestGeneric());
  Ref ref;
  SendChatRequestUseCase sendChatRequestUseCase =
      sl.get<SendChatRequestUseCase>();
  ReadAllPeopleUseCase readAllPeopleUseCase = sl.get<ReadAllPeopleUseCase>();
  FetchPendingRequestUseCase fetchPendingRequestUseCase =
      sl.get<FetchPendingRequestUseCase>();
  FetchChatRequestUseCase fetchChatRequestUseCase =
      sl.get<FetchChatRequestUseCase>();

  AcceptChatRequestUseCase acceptChatRequestUseCase =
      sl.get<AcceptChatRequestUseCase>();

  FetchFriendsUseCase fetchFriendsUseCase = sl.get<FetchFriendsUseCase>();
  RemoveFriendUseCase removeFriendUseCase = sl.get<RemoveFriendUseCase>();

  sendChatRequest(String receiverUid) async {
    state = state.update(isSendChatRequestLoading: true);
    debug("state = ${state.isSendChatRequestLoading}");
    //todo: implement local storage for uid
    String senderUid = FirebaseHandler.auth.currentUser?.uid ?? "";
    ChatRequestEntity params = ChatRequestEntity(
        senderUid: senderUid, receiverUid: receiverUid, status: "pending");
    Either<Failure, ChatRequestEntity> response =
        await sendChatRequestUseCase.call(params);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) async {
      BotToast.showText(text: "Chat request sent Successfully");
      await ref.read(chatRequestProvider.notifier).fetchPendingRequest();
      await ref.read(peopleProvider.notifier).readAllPeople();
    });
    state = state.update(isSendChatRequestLoading: false);
    debug("state = ${state.isSendChatRequestLoading}");
  }

  updateRequestStatus(String status, String senderUid) async {
    state = state.update(isUpdateRequestStatusLoading: true);
    //todo: implement local storage for uid
    String receiverUid = FirebaseHandler.auth.currentUser?.uid ?? "";
    ChatRequestEntity params = ChatRequestEntity(
        status: status, senderUid: senderUid, receiverUid: receiverUid);
    if (status == "accepted") {
      params.acceptedAt = DateTime.now();
    }
    Either<Failure, Success> response =
        await acceptChatRequestUseCase.call(params);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) async {
      BotToast.showText(text: right.message);
      await ref.read(chatRequestProvider.notifier).fetchChatRequest();
      await ref.read(chatRequestProvider.notifier).fetchFriends();
    });
    state = state.update(isUpdateRequestStatusLoading: false);
  }

  fetchPendingRequest() async {
    bool isSuccess = false;
    List<ChatRequestEntity> listOfChatRequestEntity = [];
    state = state.update(isPendingRequestLoading: true);
    FilterDto params = FilterDto(
        firebaseWhereModel:
            FirebaseWhereModel(field: "status", isEqualTo: "pending"));

    Either<Failure, List<ChatRequestEntity>> response =
        await fetchPendingRequestUseCase.call(params);

    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      listOfChatRequestEntity = right;
      isSuccess = true;
    });

    if (isSuccess && listOfChatRequestEntity.isNotEmpty) {
      FirebaseWhereModel whereModel = FirebaseWhereModel(
        field: "uid",
        whereIn: listOfChatRequestEntity.map((e) => e.receiverUid).toList(),
      );
      FilterDto params = FilterDto(firebaseWhereModel: whereModel);
      Either<Failure, List<ProfileEntity>> response =
          await readAllPeopleUseCase.call(params);

      response.fold((left) {
        BotToast.showText(text: left.message);
      }, (right) {
        state = state.update(listOfPendingRequest: right);
        BotToast.showText(text: "Fetched pending request successfully");
      });
    }

    state = state.update(isPendingRequestLoading: false);
  }

  fetchChatRequest() async {
    bool isSuccess = false;
    List<ChatRequestEntity> listOfChatRequestEntity = [];
    state = state.update(isChatRequestLoading: true, listOfChatRequest: []);
    FilterDto params = FilterDto(
        firebaseWhereModel:
            FirebaseWhereModel(field: "status", isEqualTo: "pending"));

    Either<Failure, List<ChatRequestEntity>> response =
        await fetchChatRequestUseCase.call(params);

    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      listOfChatRequestEntity = right;

      isSuccess = true;
    });

    if (isSuccess && listOfChatRequestEntity.isNotEmpty) {
      FirebaseWhereModel whereModel = FirebaseWhereModel(
        field: "uid",
        whereIn: listOfChatRequestEntity.map((e) => e.senderUid).toList(),
      );
      FilterDto params = FilterDto(firebaseWhereModel: whereModel);
      Either<Failure, List<ProfileEntity>> response =
          await readAllPeopleUseCase.call(params);

      response.fold((left) {
        BotToast.showText(text: left.message);
      }, (right) {
        state = state.update(listOfChatRequest: right);
        BotToast.showText(text: "Fetched chat request successfully");
      });
    }

    state = state.update(isChatRequestLoading: false);
  }

  fetchFriends() async {
    bool isSuccess = false;
    List<ChatRequestEntity> listOfFriends = [];
    String userId = FirebaseHandler.auth.currentUser?.uid ?? "";
    state = state.update(isFriendsLoading: true);
    FilterDto params = FilterDto(
        firebaseWhereModel:
            FirebaseWhereModel(field: "status", isEqualTo: "accepted"));

    Either<Failure, List<ChatRequestEntity>> response =
        await fetchFriendsUseCase.call(params);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      for (ChatRequestEntity c in right) {}
      listOfFriends = right;
      isSuccess = true;
    });

    if (isSuccess) {
      if (listOfFriends.isNotEmpty) {
        // filtering all uid except the current users uid
        Set<String> allUid = {};
        for (ChatRequestEntity f in listOfFriends) {
          if (f.senderUid != userId) {
            allUid.add(f.senderUid ?? "");
          }
          if (f.receiverUid != userId) {
            allUid.add(f.receiverUid ?? "");
          }
        }
        await fetchAllFriendsProfileData(allUid);

        {
          ref.read(storyProvider).update(friendsStories: []);
          for (String id in allUid) {
            await ref.read(storyProvider.notifier).getStories(uid: id);
          }
          debug("friends stories: ${ref.read(storyProvider).friendsStories}");
        }
      } else {
        state = state.update(listOfFriends: []);
      }
    }

    state = state.update(isFriendsLoading: false);
  }

  Future<void> fetchAllFriendsProfileData(Set<String> allUid) async {
    FirebaseWhereModel whereModel = FirebaseWhereModel(
      field: "uid",
      whereIn: allUid.toList(),
    );
    FilterDto params = FilterDto(firebaseWhereModel: whereModel);
    Either<Failure, List<ProfileEntity>> response =
        await readAllPeopleUseCase.call(params);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      state = state.update(listOfFriends: right);
      BotToast.showText(text: "Fetched friends successfully");
    });
  }

  removeFriend(String friendUid) async {
    state = state.update(isRemoveFriendLoading: true);
    String userUid = FirebaseHandler.auth.currentUser?.uid ?? "";
    FriendShipDto params =
        FriendShipDto(userUid: userUid, friendUid: friendUid);
    Either<Failure, Success> response = await removeFriendUseCase.call(params);

    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      BotToast.showText(text: right.message);
    });
    state = state.update(isRemoveFriendLoading: false);
  }
}
