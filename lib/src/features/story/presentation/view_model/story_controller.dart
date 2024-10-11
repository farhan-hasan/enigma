import 'package:bot_toast/bot_toast.dart';
import 'package:dartz/dartz.dart';
import 'package:enigma/src/core/network/responses/failure_response.dart';
import 'package:enigma/src/core/network/responses/success_response.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/story/domain/entity/story_entity.dart';
import 'package:enigma/src/features/story/domain/usecase/add_story_usecase.dart';
import 'package:enigma/src/features/story/domain/usecase/get_stories_usecase.dart';
import 'package:enigma/src/features/story/presentation/view_model/story_generic.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final storyProvider = StateNotifierProvider<StoryController, StoryGeneric>(
  (ref) => StoryController(ref),
);

class StoryController extends StateNotifier<StoryGeneric> {
  StoryController(this.ref) : super(StoryGeneric());
  Ref ref;

  AddStoryUseCase addStoryUseCase = sl.get<AddStoryUseCase>();
  GetStoriesUseCase getStoriesUseCase = sl.get<GetStoriesUseCase>();

  addStory({required StoryEntity storyEntity}) async {
    Either<Failure, Success> response = await addStoryUseCase.call(storyEntity);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      BotToast.showText(text: right.message);
    });
  }

  getStories({required uid}) async {
    List<List<StoryEntity>> listOfFriendsStories = state.listOfFriendsStories
        .map((innerList) => innerList.toList())
        .toList(); // Convert to mutable
    Either<Failure, List<StoryEntity>> response =
        await getStoriesUseCase.call(uid);
    response.fold((left) {
      BotToast.showText(text: left.message);
    }, (right) {
      BotToast.showText(text: "Fetched stories successfully");
      listOfFriendsStories.add(right);
      debug("uid: $uid");
      for (var f in listOfFriendsStories) {
        for (var l in f) {
          debug(l.toString());
        }
      }
      state = state.update(listOfFriendsStories: listOfFriendsStories);
    });
  }
}
