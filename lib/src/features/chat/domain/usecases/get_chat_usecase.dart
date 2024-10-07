import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/chat/data/model/chat_model.dart';
import 'package:enigma/src/features/chat/data/repository/chat_repository_impl.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/chat/domain/repository/chat_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class GetChatUsecase
    extends UseCase<Either<Failure, List<ChatEntity>>, String> {
  final ChatRepository _chatRepository = sl.get<ChatRepositoryImpl>();

  @override
  Future<Either<Failure, List<ChatEntity>>> call(String params) async {
    Either<Failure, List<ChatModel>> response = await _chatRepository.getChat(
      roomID: params,
    );
    return response.map(
        (listChatEntity) => listChatEntity.map((e) => e.toEntity()).toList());
  }
}
