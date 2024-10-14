import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/story/data/data_source/remote/story_remote_data_source.dart';
import 'package:enigma/src/features/story/domain/dto/story_dto.dart';
import 'package:enigma/src/features/story/domain/entity/user_story_entity.dart';
import 'package:enigma/src/features/story/domain/repository/story_repository.dart';

class StoryRepositoryImpl extends StoryRepository {
  final StoryRemoteDataSource _storyRemoteDataSource = StoryRemoteDataSource();

  @override
  Future<Either<Failure, Success>> addStory(
      {required StoryDto storyDto}) async {
    Either<Failure, Success> response =
        await _storyRemoteDataSource.addStory(storyDto: storyDto);
    return response;
  }

  @override
  Future<Either<Failure, UserStoryEntity>> getStories(
      {required String uid}) async {
    Either<Failure, UserStoryEntity> response =
        await _storyRemoteDataSource.getStories(uid: uid);

    return response;
  }
}
