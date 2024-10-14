import 'package:enigma/src/features/story/domain/entity/story_entity.dart';
import 'package:enigma/src/features/story/domain/entity/user_story_entity.dart';

class StoryDto {
  UserStoryEntity userStoryEntity;
  StoryEntity storyEntity;

  StoryDto({required this.userStoryEntity, required this.storyEntity});
}
