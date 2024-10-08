import 'dart:convert';

import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_controller.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_generic.dart';
import 'package:enigma/src/features/profile/presentation/view_model/controller/people_controller.dart';
import 'package:enigma/src/shared/widgets/circular_display_picture.dart';
import 'package:enigma/src/shared/widgets/icon_button_with_dropdown.dart';
import 'package:enigma/src/shared/widgets/shared_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FriendsScreen extends ConsumerStatefulWidget {
  FriendsScreen({super.key, required this.data});

  Map<String, dynamic> data;
  ChatRequestEntity? chatRequestEntity;
  static const route = "/chat_request/:chat_request_entity";
  static setRoute({required ChatRequestEntity chatRequestEntity}) =>
      "chat_request/${jsonEncode(chatRequestEntity.toJson())}";

  @override
  ConsumerState<FriendsScreen> createState() => _ChatRequestScreenState();
}

class _ChatRequestScreenState extends ConsumerState<FriendsScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {
      ref.read(chatRequestProvider.notifier).fetchFriends();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ChatRequestGeneric chatRequestController =
        ref.watch(chatRequestProvider);
    return Scaffold(
      appBar: SharedAppbar(
        title: const Text("Friends"),
        leadingWidget: InkWell(
          onTap: () {
            ref.read(goRouterProvider).pop();
          },
          child: Container(
            height: context.height * .05,
            width: context.width * .05,
            margin: const EdgeInsets.all(8),
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_outlined,
                size: 25,
              ),
            ),
          ),
        ),
      ),
      body: buildPeopleSection(context, chatRequestController),
    );
  }

  Widget buildPeopleSection(
      BuildContext context, ChatRequestGeneric chatRequestController) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: ListView.separated(
        primary: true,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      CircularDisplayPicture(
                        radius: 23,
                        imageURL: chatRequestController
                            .listOfFriends[index].avatarUrl,
                      ),
                      const Positioned(
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            Icons.circle,
                            color: Colors.green,
                            size: 15,
                          ))
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        chatRequestController.listOfFriends[index].name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          chatRequestController.listOfFriends[index].createdAt
                                  .toString() ??
                              "",
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.labelSmall)
                    ],
                  ),
                ],
              ),
              IconButtonWithDropdown(
                popupMenuEntryList: [
                  PopupMenuItem<String>(
                    onTap: () async {
                      print('Selected: Remove');
                      await ref.read(chatRequestProvider.notifier).removeFriend(
                          chatRequestController.listOfFriends[index].uid ?? "");
                      await ref
                          .read(chatRequestProvider.notifier)
                          .fetchFriends();
                      await ref.read(peopleProvider.notifier).readAllPeople();
                    },
                    value: 'Remove',
                    child: const Text('Remove'),
                  ),
                  PopupMenuItem<String>(
                    onTap: () async {
                      print('Selected: Block');
                      await ref
                          .read(chatRequestProvider.notifier)
                          .updateRequestStatus(
                              "blocked",
                              chatRequestController.listOfFriends[index].uid ??
                                  "");
                      await ref
                          .read(chatRequestProvider.notifier)
                          .fetchFriends();
                      await ref.read(peopleProvider.notifier).readAllPeople();
                    },
                    value: 'Block',
                    child: const Text('Block'),
                  ),
                ],
                icon: const Icon(
                  Icons.close,
                ),
                style: IconButton.styleFrom(
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
              )
            ],
          );
        },
        itemCount: chatRequestController.listOfFriends.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 30,
          );
        },
      ),
    );
  }
}
