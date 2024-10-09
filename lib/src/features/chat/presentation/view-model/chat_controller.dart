import 'dart:io';

import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/chat/domain/dto/chat_room_dto.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/chat/domain/usecases/add_chat_usecase.dart';
import 'package:enigma/src/features/chat/domain/usecases/get_chat_usecase.dart';
import 'package:enigma/src/features/chat/presentation/view-model/chat_generic.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/dto/profile_picture_dto.dart';
import 'package:enigma/src/shared/domain/use_cases/profile_picture_usecase.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final chatProvider = StateNotifierProvider<ChatController, ChatGeneric>(
  (ref) => ChatController(ref),
);

class ChatController extends StateNotifier<ChatGeneric> {
  ChatController(this.ref) : super(ChatGeneric());
  Ref ref;

  AddChatUsecase addChatUsecase = sl.get<AddChatUsecase>();
  GetChatUsecase getChatUsecase = sl.get<GetChatUsecase>();
  ImageMediaUsecase imageMediaUsecase = sl.get<ImageMediaUsecase>();

  Future<void> addChat(ChatEntity chatEntity) async {
    Either<Failure, Success> response = await addChatUsecase.call(chatEntity);
    response.fold(
      (left) {
        BotToast.showText(text: left.message);
      },
      (right) {},
    );
  }

  Future<Stream<List<ChatEntity>>> getChat(
      {required String myUid, required String friendUid}) async {
    ChatRoomDto chatRoomDto = ChatRoomDto(myUid: myUid, friendUid: friendUid);
    final response = await getChatUsecase.call(chatRoomDto);
    // debug("From Chat Controller ${response.runtimeType}");

    return response;
  }

  Future<String?> addImageMedia({
    required File file,
    required String directory,
    required String fileName,
  }) async {
    String? url;
    ImageMediaDto params = ImageMediaDto(
      file: file,
      directory: directory,
      fileName: fileName,
    );
    Either<Failure, Success> response = await imageMediaUsecase.call(params);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      debug(right.message);
      url = right.message;
    });
    return url;
  }
}
