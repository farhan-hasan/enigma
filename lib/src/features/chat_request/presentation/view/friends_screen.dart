import 'dart:convert';

import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_controller.dart';
import 'package:enigma/src/features/profile/presentation/view_model/controller/profile_controller.dart';
import 'package:enigma/src/features/profile/presentation/view_model/generic/profile_generic.dart';
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
    final ProfileGeneric profileController = ref.watch(profileProvider);
    return Scaffold(
      appBar: SharedAppbar(
        title: const Text("Friends"),
        leadingWidget: InkWell(
          onTap: () {
            ref.read(goRouterProvider).pop();
          },
          child: const Icon(
            Icons.arrow_back_outlined,
            size: 25,
          ),
        ),
      ),
      body: buildPeopleSection(context, profileController),
    );
  }

  Widget buildPeopleSection(
      BuildContext context, ProfileGeneric profileController) {
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
                        imageURL:
                            profileController.listOfFriends[index].avatarUrl,
                      ),
                      Positioned(
                          right: 0,
                          bottom: 0,
                          child: Icon(
                            Icons.circle,
                            color: (profileController
                                        .listOfFriends[index].isActive ??
                                    false)
                                ? Colors.green
                                : Colors.transparent,
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
                        profileController.listOfFriends[index].name ?? "",
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                      Text(
                          profileController.listOfFriends[index].createdAt
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
                      await ref.read(chatRequestProvider.notifier).removeFriend(
                          profileController.listOfFriends[index].uid ?? "");
                      await ref
                          .read(chatRequestProvider.notifier)
                          .fetchFriends();
                      await ref.read(profileProvider.notifier).readAllPeople();
                    },
                    value: 'Remove',
                    child: const Text('Remove'),
                  ),
                  PopupMenuItem<String>(
                    onTap: () async {
                      await ref
                          .read(chatRequestProvider.notifier)
                          .updateRequestStatus("blocked",
                              profileController.listOfFriends[index].uid ?? "");
                      await ref
                          .read(chatRequestProvider.notifier)
                          .fetchFriends();
                      await ref.read(profileProvider.notifier).readAllPeople();
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
        itemCount: profileController.listOfFriends.length,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            height: 30,
          );
        },
      ),
    );
  }
}
