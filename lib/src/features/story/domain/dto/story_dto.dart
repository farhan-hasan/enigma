import 'package:enigma/src/features/story/domain/entity/story_entity.dart';

class StoryDto {
  String uid;
  StoryEntity storyEntity;

  StoryDto({required this.uid, required this.storyEntity});
}
