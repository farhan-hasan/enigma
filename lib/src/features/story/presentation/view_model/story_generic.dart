import 'package:enigma/src/features/story/domain/entity/story_entity.dart';

class StoryGeneric {
  bool isLoading;
  List<List<StoryEntity>> listOfFriendsStories;

  StoryGeneric({this.isLoading = false, this.listOfFriendsStories = const []});

  StoryGeneric update(
      {bool? isLoading, List<List<StoryEntity>>? listOfFriendsStories}) {
    return StoryGeneric(
        isLoading: isLoading ?? this.isLoading,
        listOfFriendsStories:
            listOfFriendsStories ?? this.listOfFriendsStories);
  }
}
