import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/chat/presentation/components/chat_screen_bottom_bar.dart';
import 'package:enigma/src/features/chat/presentation/components/chat_ui.dart';
import 'package:enigma/src/features/chat/presentation/view-model/chat_controller.dart';
import 'package:enigma/src/features/profile/presentation/view_model/controller/profile_controller.dart';
import 'package:enigma/src/features/profile/presentation/view_model/generic/profile_generic.dart';
import 'package:enigma/src/shared/widgets/circular_display_picture.dart';
import 'package:enigma/src/shared/widgets/shared_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends ConsumerStatefulWidget {
  ChatScreen({super.key, required this.data});

  static const String route = "/chat/:chat_id";
  String data;

  static setRoute({required String chatId}) => "/chat/$chatId";

  @override
  ConsumerState<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends ConsumerState<ChatScreen> {
  final String userUid = FirebaseHandler.auth.currentUser?.uid ?? "";
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      await ref.read(profileProvider.notifier).readProfile(widget.data);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ProfileGeneric profileController = ref.watch(profileProvider);
    return Scaffold(
        appBar: SharedAppbar(
          titleSpacing: -context.width * 0.04,
          leadingWidget: InkWell(
            onTap: () {
              ref.read(goRouterProvider).pop();
            },
            child: const Icon(
              Icons.arrow_back_outlined,
              size: 25,
            ),
          ),
          title: ListTile(
            leading: CircularDisplayPicture(
              radius: 23,
              imageURL: profileController.profileEntity?.avatarUrl ?? null,
            ),
            title: Text(
              profileController.profileEntity?.name ?? "",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            subtitle: Text(
              (profileController.profileEntity?.isActive ?? false)
                  ? "Active Now"
                  : "",
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          trailingWidgets: [
            CircleAvatar(
              radius: context.width * 0.05,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Icon(
                Icons.call_outlined,
                color: Theme.of(context).canvasColor,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            CircleAvatar(
              radius: context.width * 0.05,
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              child: Icon(
                Icons.video_camera_front_outlined,
                color: Theme.of(context).canvasColor,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Expanded(
              child: FutureBuilder<Stream<List<ChatEntity>>>(
                  future: ref.read(chatProvider.notifier).getChat(
                        myUid: userUid,
                        friendUid: profileController.profileEntity?.uid ?? "",
                      ),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return StreamBuilder<List<ChatEntity>>(
                        stream: snapshot.data,
                        builder: (context, chatShot) {
                          // debug("From Chat Screen ${chatShot.data}");
                          if (chatShot.hasData) {
                            return ChatUI(chat: chatShot.data ?? []);
                          } else {
                            return const Center(
                                child: Text('No messages found'));
                          }

                          // if (!snapshot.hasData || snapshot.data!.isEmpty) {
                          //   return const Center(
                          //       child: Text('No messages found'));
                          // } else {
                          //   return ChatUI(chat: snapshot.data!);
                          // }
                        },
                      );
                    } else {
                      return const Center(child: CircularProgressIndicator());
                    }
                  }),
            ),
            ChatScreenBottomBar(
              sender: userUid,
              receiver: profileController.profileEntity?.uid ?? "",
            ),
            // ChatUI(textMessage: textMessage)
          ],
        ));
  }
}
