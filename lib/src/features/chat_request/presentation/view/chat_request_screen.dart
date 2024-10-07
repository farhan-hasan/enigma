import 'dart:convert';

import 'package:enigma/src/core/router/router.dart';
import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_controller.dart';
import 'package:enigma/src/features/chat_request/presentation/view_model/chat_request_generic.dart';
import 'package:enigma/src/shared/widgets/circular_display_picture.dart';
import 'package:enigma/src/shared/widgets/shared_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ChatRequestScreen extends ConsumerStatefulWidget {
  ChatRequestScreen({super.key, required this.data});

  Map<String, dynamic> data;
  ChatRequestEntity? chatRequestEntity;
  static const route = "/chat_request/:chat_request_entity";
  static setRoute({required ChatRequestEntity chatRequestEntity}) =>
      "chat_request/${jsonEncode(chatRequestEntity.toJson())}";

  @override
  ConsumerState<ChatRequestScreen> createState() => _ChatRequestScreenState();
}

class _ChatRequestScreenState extends ConsumerState<ChatRequestScreen> {
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((t) {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ChatRequestGeneric chatRequestController =
        ref.watch(chatRequestProvider);
    return Scaffold(
      appBar: SharedAppbar(
        title: "Chat Requests",
        leadingWidget: GestureDetector(
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
    if (chatRequestController.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
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
                          chatRequestController.listOfChatRequest[index].name ??
                              "",
                          overflow: TextOverflow.ellipsis,
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
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.check,
                      ),
                      style:
                          IconButton.styleFrom(backgroundColor: Colors.green),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.close),
                      style: IconButton.styleFrom(backgroundColor: Colors.red),
                    ),
                  ],
                )
              ],
            );
          },
          itemCount: chatRequestController.listOfChatRequest.length,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 30,
            );
          },
        ),
      );
    }
  }
}
