import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/network/remote/firebase/model/firebase_where_model.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/fetch_chat_request_usecase.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/fetch_pending_request_usecase.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/send_chat_request_usecase.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_generic.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/domain/usecases/read_all_people_usecase.dart';
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

  sendChatRequest(String receiverUid) async {
    //state = state.update(isLoading: true);
    //todo: implement local storage for uid
    String senderUid = FirebaseHandler.auth.currentUser?.uid ?? "";
    ChatRequestEntity params = ChatRequestEntity(
        senderUid: senderUid, receiverUid: receiverUid, status: "pending");
    Either<Failure, ChatRequestEntity> response =
        await sendChatRequestUseCase.call(params);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      BotToast.showText(text: "Chat request sent Successfully");
    });
    //state = state.update(isLoading: false);
  }

  fetchPendingRequest() async {
    bool isSuccess = false;
    List<ChatRequestEntity> listOfChatRequestEntity = [];
    state = state.update(isLoading: true);
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

    state = state.update(isLoading: false);
  }

  fetchChatRequest() async {
    bool isSuccess = false;
    List<ChatRequestEntity> listOfChatRequestEntity = [];
    state = state.update(isLoading: true);
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

    state = state.update(isLoading: false);
  }
}
