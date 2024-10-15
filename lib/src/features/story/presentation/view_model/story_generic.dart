import 'package:enigma/src/features/story/domain/entity/user_story_entity.dart';

class StoryGeneric {
  bool isLoading;
  List<UserStoryEntity> friendsStories;
  UserStoryEntity? myStory;

  StoryGeneric(
      {this.isLoading = false, this.friendsStories = const [], this.myStory});

  StoryGeneric update(
      {bool? isLoading,
      List<UserStoryEntity>? friendsStories,
      UserStoryEntity? myStory}) {
    return StoryGeneric(
      isLoading: isLoading ?? this.isLoading,
      myStory: myStory ?? this.myStory,
      friendsStories: friendsStories ?? this.friendsStories,
    );
  }
}
