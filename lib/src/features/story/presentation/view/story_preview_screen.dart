import 'dart:io';

import 'package:enigma/src/core/database/local/shared_preference/shared_preference_keys.dart';
import 'package:enigma/src/core/database/local/shared_preference/shared_preference_manager.dart';
import 'package:enigma/src/core/network/remote/firebase/firebase_storage_directory_name.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/chat/presentation/view-model/chat_controller.dart';
import 'package:enigma/src/features/story/domain/entity/story_entity.dart';
import 'package:enigma/src/features/story/domain/entity/user_story_entity.dart';
import 'package:enigma/src/features/story/presentation/view_model/story_controller.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

class StoryPreviewScreen extends ConsumerStatefulWidget {
  const StoryPreviewScreen({super.key, required this.mediaFile});
  final File mediaFile;

  // static const String route = "/story_preview/:media";
  //
  // static setRoute({required String media}) => "/story_preview/$media";

  static const String route = "/story_preview";

  @override
  ConsumerState<StoryPreviewScreen> createState() => _StoryPreviewScreenState();
}

class _StoryPreviewScreenState extends ConsumerState<StoryPreviewScreen> {
  TextEditingController storyCaptionTEC = TextEditingController();
  SharedPreferenceManager sharedPreferenceManager =
      sl.get<SharedPreferenceManager>();
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) async {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Stack(
          children: [
            Align(
                alignment: Alignment.center,
                child: SizedBox(
                  height: context.height / 1.5,
                  child: Image(
                    image: FileImage(widget.mediaFile ?? File("")),
                  ),
                )),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: storyCaptionTEC,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Theme.of(context).colorScheme.secondary,
                        hintText: "Write your caption",
                        border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () async {
                      Uuid uuid = const Uuid();
                      String? mediaLink =
                          await ref.read(chatProvider.notifier).addImageMedia(
                                file: widget.mediaFile,
                                directory: FirebaseStorageDirectoryName
                                    .STORY_MEDIA_DIRECTORY,
                                fileName: widget.mediaFile.path.split("/").last,
                              );
                      String uid = sharedPreferenceManager.getValue(
                          key: SharedPreferenceKeys.USER_UID);
                      String userName = sharedPreferenceManager.getValue(
                          key: SharedPreferenceKeys.USER_NAME);

                      UserStoryEntity userStoryEntity =
                          UserStoryEntity(uid: uid, name: userName);

                      StoryEntity storyEntity = StoryEntity(
                        id: uuid.v4(),
                        uid: uid,
                        type: mediaLink != null
                            ? MediaType.image
                            : MediaType.text,
                        mediaLink: mediaLink,
                        timestamp: DateTime.now(),
                      );
                      if (storyCaptionTEC.text.trim().isNotEmpty) {
                        storyEntity.content = storyCaptionTEC.text.trim();
                      }

                      await ref.read(storyProvider.notifier).addStory(
                          storyEntity: storyEntity,
                          userStoryEntity: userStoryEntity);

                      ref.read(goRouterProvider).pop();
                    },
                    child: CircleAvatar(
                      //radius: context.width * 0.05,
                      backgroundColor: Colors.transparent,
                      child: Icon(
                        Icons.send,
                        color: Theme.of(context).canvasColor,
                      ),
                    ),
                  )
                ],
              ),
            ),
            // ChatUI(textMessage: textMessage)
          ],
        ),
      ),
    );
  }
}
