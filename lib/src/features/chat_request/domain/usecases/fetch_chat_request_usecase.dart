import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/chat_request/data/repository/chat_request_repository_impl.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/chat_request/domain/repository/chat_request_repository.dart';
import 'package:enigma/src/features/profile/domain/dto/filter_dto.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class FetchChatRequestUseCase
    extends UseCase<Either<Failure, List<ChatRequestEntity>>, FilterDto> {
  final ChatRequestRepository _chatRequestRepository =
      sl.get<ChatRequestRepositoryImpl>();

  @override
  Future<Either<Failure, List<ChatRequestEntity>>> call(
      FilterDto params) async {
    Either<Failure, List<ChatRequestEntity>> response =
        await _chatRequestRepository.fetchChatRequest(filter: params);

    return response.map((listChatRequestEntity) => listChatRequestEntity
        .map(
          (e) => e,
        )
        .toList());
  }
}
