import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/story/data/repository/story_repository_impl.dart';
import 'package:enigma/src/features/story/domain/dto/story_dto.dart';
import 'package:enigma/src/features/story/domain/repository/story_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class AddStoryUseCase extends UseCase<Either<Failure, Success>, StoryDto> {
  final StoryRepository _storyRepository = sl.get<StoryRepositoryImpl>();
  @override
  Future<Either<Failure, Success>> call(StoryDto params) async {
    Either<Failure, Success> response =
        await _storyRepository.addStory(storyDto: params);
    return response;
  }
}
