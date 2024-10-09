import 'dart:convert';

import 'package:enigma/src/core/network/remote/firebase/firebase_handler.dart';
import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/core/utils/logger/logger.dart';
import 'package:enigma/src/features/chat_request/presentation/view/friends_screen.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_controller.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_generic.dart';
import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';
import 'package:enigma/src/features/profile/presentation/view_model/controller/people_controller.dart';
import 'package:enigma/src/features/profile/presentation/view_model/generic/people_generic.dart';
import 'package:enigma/src/shared/dependency_injection/dependency_injection.dart';
import 'package:enigma/src/shared/widgets/circular_display_picture.dart';
import 'package:enigma/src/shared/widgets/shared_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_reactive_ble/flutter_reactive_ble.dart';
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
    init();
    super.initState();
  }

  init() async {
    WidgetsBinding.instance.addPostFrameCallback((t) async {
      await ref.read(chatRequestProvider.notifier).fetchPendingRequest();
      await ref.read(chatRequestProvider.notifier).fetchChatRequest();
      await ref.read(chatRequestProvider.notifier).fetchFriends();
      await ref.read(peopleProvider.notifier).readAllPeople();
    });
  }

  @override
  Widget build(BuildContext context) {
    final PeopleGeneric peopleController = ref.watch(peopleProvider);
    final ChatRequestGeneric chatRequestController =
        ref.watch(chatRequestProvider);
    ref.watch(chatRequestProvider);
    return Scaffold(
      appBar: SharedAppbar(
          title: Text("People"),
          leadingWidget: GestureDetector(
            onTap: () {},
            child: const Icon(
              Icons.search,
              size: 25,
            ),
          ),
          trailingWidgets: [
            GestureDetector(
              onTap: () {},
              child: Container(
                width: context.width * .1,
                height: context.width * .1,
                margin: const EdgeInsets.all(8),
                child: const Icon(
                  Icons.person_add_outlined,
                  size: 25,
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
              if (chatRequestController.listOfChatRequest.isNotEmpty)
                buildChatRequestsSection(
                    context, peopleController, chatRequestController),
              if (chatRequestController.listOfPendingRequest.isNotEmpty)
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
        ref.read(goRouterProvider).push(FriendsScreen.route);
      },
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          //border: Border.all(color: Colors.grey),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Friends",
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Theme.of(context).canvasColor),
            ),
            Icon(
              Icons.arrow_forward_rounded,
              color: Theme.of(context).canvasColor,
            )
          ],
        ),
      ),
    );
  }

  Widget buildChatRequestsSection(
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
          ListView.builder(
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
                        onPressed: () async {
                          String receiverUid = chatRequestController
                                  .listOfChatRequest[index].uid ??
                              "";
                          String status = "accepted";
                          await ref
                              .read(chatRequestProvider.notifier)
                              .updateRequestStatus(status, receiverUid);
                        },
                        icon: const Icon(
                          Icons.check,
                        ),
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white),
                      ),
                      IconButton(
                        onPressed: () async {
                          String receiverUid = chatRequestController
                                  .listOfChatRequest[index].uid ??
                              "";
                          String status = "rejected";
                          await ref
                              .read(chatRequestProvider.notifier)
                              .updateRequestStatus(status, receiverUid);
                        },
                        icon: const Icon(Icons.close),
                        style: IconButton.styleFrom(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white),
                      ),
                    ],
                  )
                ],
              );
            },
            itemCount: chatRequestController.listOfChatRequest.length,
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
          ListView.builder(
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
          // Temporary inkwell for discovery testing
          InkWell(
              onTap: () {
                Set<String> macs = {};
                print("Tapped");
                sl.get<FlutterReactiveBle>().scanForDevices(
                    withServices: [],
                    scanMode: ScanMode.balanced).listen((device) {
                  debug("name, id : ${device.name} , ${device.id}");
                  debug("total device : ${macs.length}");
                  debug(device.toString());
                  macs.add(device.id);
                }, onError: (e) {
                  debug(e.toString());
                });
              },
              child: const Text("Discover")),
          const SizedBox(
            height: 20,
          ),
          ListView.builder(
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
                            imageURL:
                                peopleController.listOfPeople[index].avatarUrl,
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
                  Visibility(
                    visible: !chatRequestController.isSendChatRequestLoading,
                    replacement:
                        const Center(child: CircularProgressIndicator()),
                    child: IconButton(
                      onPressed: () async {
                        // todo: implement sembast for sender uid
                        String sender =
                            FirebaseHandler.auth.currentUser?.uid ?? "";
                        String receiver =
                            peopleController.listOfPeople[index].uid ?? "";
                        await ref
                            .read(chatRequestProvider.notifier)
                            .sendChatRequest(
                                peopleController.listOfPeople[index].uid ?? "");
                      },
                      icon: const Icon(
                        Icons.add,
                      ),
                    ),
                  )
                ],
              );
            },
            itemCount: peopleController.listOfPeople.length,
          ),
        ],
      ),
    );
  }
}
