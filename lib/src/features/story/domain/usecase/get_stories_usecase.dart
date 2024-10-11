import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/features/story/data/repository/story_repository_impl.dart';
import 'package:enigma/src/features/story/domain/entity/story_entity.dart';
import 'package:enigma/src/features/story/domain/repository/story_repository.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/domain/use_cases/base_use_case.dart';

class GetStoriesUseCase
    extends UseCase<Either<Failure, List<StoryEntity>>, String> {
  final StoryRepository _storyRepository = sl.get<StoryRepositoryImpl>();
  @override
  Future<Either<Failure, List<StoryEntity>>> call(String params) async {
    Either<Failure, List<StoryEntity>> response =
        await _storyRepository.getStories(uid: params);
    return response;
  }
}
