import 'dart:convert';

import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/features/chat_request/presentation/view/chat_request_screen.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_controller.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_generic.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/presentation/view_model/controller/people_controller.dart';
import 'package:enigma/src/features/profile/presentation/view_model/generic/people_generic.dart';
import 'package:enigma/src/shared/widgets/circular_display_picture.dart';
import 'package:enigma/src/shared/widgets/shared_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PeopleScreen extends ConsumerStatefulWidget {
  PeopleScreen({super.key, required this.data});

  Map<String, dynamic> data;
  ProfileEntity? peopleEntity;
  static const route = "/people/:people_entity";
  static setRoute({required ProfileEntity profileEntity}) =>
      "/people/${jsonEncode(profileEntity.toJson())}";

  @override
  ConsumerState<PeopleScreen> createState() => _PeopleScreenState();
}

class _PeopleScreenState extends ConsumerState<PeopleScreen> {
  @override
  void initState() {
    //todo: please implement sembast asap :'D
    String uid = FirebaseHandler.auth.currentUser?.uid ?? "";
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      ref.read(peopleProvider.notifier).readAllPeople();
      ref.read(chatRequestProvider.notifier).fetchPendingRequest();
      ref.read(chatRequestProvider.notifier).fetchChatRequest();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PeopleGeneric peopleController = ref.watch(peopleProvider);
    final ChatRequestGeneric chatRequestController =
        ref.watch(chatRequestProvider);
    ref.watch(chatRequestProvider);
    return Scaffold(
      appBar: SharedAppbar(
          title: "People",
          leadingWidget: GestureDetector(
            onTap: () {},
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
                  Icons.search,
                  size: 25,
                ),
              ),
            ),
          ),
          trailingWidgets: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: context.width * .1,
                height: context.width * .1,
                margin: const EdgeInsets.all(8),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey),
                  ),
                  child: const Icon(
                    Icons.person_add_outlined,
                    size: 25,
                  ),
                ),
              ),
            )
          ]),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              // Chat requests
              buildFriendsSection(context, chatRequestController),
              // People list
              buildFriendRequestsSection(
                  context, peopleController, chatRequestController),
              buildPendingRequestsSection(
                  context, peopleController, chatRequestController),
              buildDiscoverSection(
                  context, peopleController, chatRequestController)
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFriendsSection(
      BuildContext context, ChatRequestGeneric chatRequestController) {
    return InkWell(
      onTap: () {
        ref.read(goRouterProvider).push(ChatRequestScreen.route);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.black),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Friends",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.white),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
            )
          ],
        ),
      ),
    );
  }

  Widget buildFriendRequestsSection(
      BuildContext context,
      PeopleGeneric peopleController,
      ChatRequestGeneric chatRequestController) {
    return Container(
      padding: const EdgeInsets.all(20),
      //color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Chat requests"),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: !chatRequestController.isLoading,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CircularDisplayPicture(
                              radius: 23,
                              imageURL: chatRequestController
                                  .listOfChatRequest[index].avatarUrl,
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
                              chatRequestController
                                      .listOfChatRequest[index].name ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                chatRequestController
                                        .listOfChatRequest[index].createdAt
                                        .toString() ??
                                    "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall)
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.check,
                          ),
                          style: IconButton.styleFrom(
                              backgroundColor: Colors.green),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.close),
                          style:
                              IconButton.styleFrom(backgroundColor: Colors.red),
                        ),
                      ],
                    )
                  ],
                );
              },
              itemCount: chatRequestController.listOfChatRequest.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPendingRequestsSection(
      BuildContext context,
      PeopleGeneric peopleController,
      ChatRequestGeneric chatRequestController) {
    return Container(
      padding: const EdgeInsets.all(20),
      //color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Pending requests"),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: !chatRequestController.isLoading,
            replacement: const Center(child: CircularProgressIndicator()),
            child: ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CircularDisplayPicture(
                              radius: 23,
                              imageURL: chatRequestController
                                  .listOfPendingRequest[index].avatarUrl,
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
                              chatRequestController
                                      .listOfPendingRequest[index].name ??
                                  "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                chatRequestController
                                        .listOfPendingRequest[index].createdAt
                                        .toString() ??
                                    "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall)
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
              itemCount: chatRequestController.listOfPendingRequest.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildDiscoverSection(
      BuildContext context,
      PeopleGeneric peopleController,
      ChatRequestGeneric chatRequestController) {
    return Container(
      padding: const EdgeInsets.all(20),
      //color: Colors.grey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Discover"),
          const SizedBox(
            height: 20,
          ),
          Visibility(
            visible: !peopleController.isLoading,
            replacement: Center(child: CircularProgressIndicator()),
            child: ListView.builder(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CircularDisplayPicture(
                              radius: 23,
                              imageURL: peopleController
                                  .listOfPeople[index].avatarUrl,
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
                              peopleController.listOfPeople[index].name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text(
                                peopleController.listOfPeople[index].createdAt
                                        .toString() ??
                                    "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context).textTheme.labelSmall)
                          ],
                        ),
                      ],
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: () {
                          // todo: implement sembast for sender uid
                          String sender =
                              FirebaseHandler.auth.currentUser?.uid ?? "";
                          String receiver =
                              peopleController.listOfPeople[index].uid ?? "";
                          ref
                              .read(chatRequestProvider.notifier)
                              .sendChatRequest(
                                  peopleController.listOfPeople[index].uid ??
                                      "");
                        },
                        icon: const Icon(Icons.add))
                  ],
                );
              },
              itemCount: peopleController.listOfPeople.length,
            ),
          ),
        ],
      ),
    );
  }
}
