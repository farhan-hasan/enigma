import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/story/domain/entity/story_entity.dart';

abstract class StoryRepository {
  Future<Either<Failure, Success>> addStory({required StoryEntity storyEntity});

  Future<Either<Failure, List<StoryEntity>>> getStories({required String uid});
}
