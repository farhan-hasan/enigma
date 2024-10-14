import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/features/story/domain/dto/story_dto.dart';
import 'package:enigma/src/features/story/domain/entity/user_story_entity.dart';

abstract class StoryRepository {
  Future<Either<Failure, Success>> addStory({required StoryDto storyDto});

  Future<Either<Failure, UserStoryEntity>> getStories({required String uid});
}
