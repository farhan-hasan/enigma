import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/chat/domain/usecases/add_chat_usecase.dart';
import 'package:enigma/src/features/chat/domain/usecases/get_chat_usecase.dart';
import 'package:enigma/src/features/chat/presentation/view-model/chat_generic.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = StateNotifierProvider<ChatController, ChatGeneric>(
  (ref) => ChatController(ref),
);

class ChatController extends StateNotifier<ChatGeneric> {
  ChatController(this.ref) : super(ChatGeneric());
  Ref ref;

  AddChatUsecase addChatUsecase = sl.get<AddChatUsecase>();
  GetChatUsecase getChatUsecase = sl.get<GetChatUsecase>();

  addChat(ChatEntity chatEntity) async {
    Either<Failure, Success> response = await addChatUsecase.call(chatEntity);
    response.fold(
      (left) {
        BotToast.showText(text: left.message);
      },
      (right) {},
    );
  }

  // Stream<List<ChatEntity>> getChat(String uid) async* {
  //   final response = await getChatUsecase.call(uid);
  //   response.fold(
  //     (left) {
  //       BotToast.showText(text: left.message);
  //     },
  //     (right) {
  //       yield right;
  //     },
  //   );
  // }
}
