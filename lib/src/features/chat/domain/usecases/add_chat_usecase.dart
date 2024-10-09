import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/chat/data/repository/chat_repository_impl.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/chat/domain/repository/chat_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class AddChatUsecase extends UseCase<Either<Failure, Success>, ChatEntity> {
  final ChatRepository _chatRepository = sl.get<ChatRepositoryImpl>();
  @override
  Future<Either<Failure, Success>> call(ChatEntity params) async {
    final response = await _chatRepository.addChat(chatEntity: params);
    return response;
  }
}
