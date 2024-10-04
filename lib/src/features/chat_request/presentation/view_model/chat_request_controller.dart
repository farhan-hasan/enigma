import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/remote/firebase/model/firebase_where_model.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/chat_request/domain/usecases/fetch_chat_requests_usecase.dart';
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

  FetchChatRequestsUseCase fetchChatRequestsUseCase =
      sl.get<FetchChatRequestsUseCase>();

  ReadAllPeopleUseCase readAllPeopleUseCase = sl.get<ReadAllPeopleUseCase>();

  sendChatRequest(
      {required String senderUid, required String receiverUJid}) async {
    state = state.update(isLoading: true);
    ChatRequestEntity params = ChatRequestEntity(
        senderUid: senderUid, receiverUid: receiverUJid, isAccepted: false);
    Either<Failure, ChatRequestEntity> response =
        await sendChatRequestUseCase.call(params);

    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      BotToast.showText(text: "Chat request sent");
    });
    state = state.update(isLoading: false);
  }

  Future<bool> fetchChatRequests(String uid) async {
    List<String> listOfUid = [];
    bool isSuccess = false;
    state = state.update(isLoading: true);
    Either<Failure, List<ChatRequestEntity>> response =
        await fetchChatRequestsUseCase.call(uid);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) async {
      for (ChatRequestEntity chat in right) {
        listOfUid.add(chat.senderUid ?? "");
      }
      isSuccess = true;
    });

    if (isSuccess) {
      isSuccess = false;
      FilterDto params = FilterDto(
          firebaseWhereModel:
              FirebaseWhereModel(field: "uid", whereIn: listOfUid));
      Either<Failure, List<ProfileEntity>> response =
          await readAllPeopleUseCase.call(params);
      response.fold(
        (left) {
          BotToast.showText(text: left.message);
        },
        (right) {
          state = state.update(listOfPeople: right);
          BotToast.showText(text: "Fetched all chat requests successfully");
          isSuccess = true;
        },
      );
    }

    state = state.update(isLoading: false);
    return isSuccess;
  }
}
