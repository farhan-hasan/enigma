import 'dart:async';

import 'package:enigma/src/features/chat/data/model/chat_model.dart';
import 'package:enigma/src/features/chat/data/repository/chat_repository_impl.dart';
import 'package:enigma/src/features/chat/domain/dto/chat_room_dto.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/chat/domain/repository/chat_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class GetChatUsecase extends UseCase<Stream<List<ChatEntity>>, ChatRoomDto> {
  final ChatRepository _chatRepository = sl.get<ChatRepositoryImpl>();

  @override
  Future<Stream<List<ChatEntity>>> call(ChatRoomDto params) async {
    Stream<List<ChatModel>> response = await _chatRepository.getChat(
        myUid: params.myUid, friendUid: params.friendUid);

    final transformer =
        StreamTransformer<List<ChatModel>, List<ChatEntity>>.fromHandlers(
      handleData: (data, sink) {
        List<ChatEntity> entities = data.map((e) => e.toEntity()).toList();
        sink.add(entities);
      },
    );

    return response.transform(transformer);
  }
}
