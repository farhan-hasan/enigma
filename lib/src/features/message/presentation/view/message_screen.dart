import 'dart:convert';

import 'package:enigma/src/core/utils/extension/context_extension.dart';
import 'package:enigma/src/features/message/domain/entity/message_entity.dart';
import 'package:enigma/src/shared/widgets/circular_display_picture.dart';
import 'package:enigma/src/shared/widgets/shared_appbar.dart';
import 'package:flutter/material.dart';

class MessageScreen extends StatelessWidget {
  MessageScreen({super.key, required this.data}) {
    messageEntity = MessageEntity.fromJson(jsonDecode(data["message_entity"]));
  }

  Map<String, dynamic> data;
  MessageEntity? messageEntity;
  static const route = "/message/:message_entity";
  static setRoute({required MessageEntity messageEntity}) =>
      "/message/${jsonEncode(messageEntity.toJson())}";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Theme.of(context).colorScheme.secondary,
      appBar: SharedAppbar(
          title: "Home",
          leadingWidget: GestureDetector(
            onTap: () {},
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(500),
              ),
              child: const Icon(
                Icons.search,
                size: 25,
              ),
            ),
          ),
          trailingWidgets: [
            Container(
              height: 55,
              width: 55,
              padding: EdgeInsets.all(10),
              child: CircularDisplayPicture(
                radius: 30,
              ),
            )
          ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Story section
            buildStorySection(context),
            // Chat section
            buildChatSection(context)
          ],
        ),
      ),
    );
  }

  Widget buildChatSection(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(40), topRight: Radius.circular(40)),
          color: Theme.of(context).colorScheme.secondary,
        ),
        child: ListView.separated(
          padding: const EdgeInsets.only(top: 30),
          primary: false,
          shrinkWrap: false,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            CircularDisplayPicture(
                              radius: 23,
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
                        SizedBox(
                          width: context.width / 1.7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Text Linderson",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                              Text(
                                  "How are you doing today?asdsadasdasdsadsadasdaasdasdasdsaddddddddsssssssssssssssssssssss",
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.labelSmall)
                            ],
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          "2 min ago",
                          style: Theme.of(context).textTheme.labelSmall,
                        ),
                        CircleAvatar(
                          backgroundColor:
                              Theme.of(context).colorScheme.primary,
                          radius: 10,
                          child: Text(
                            "3",
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.secondary,
                                fontSize: 10),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          },
          itemCount: 20,
          separatorBuilder: (BuildContext context, int index) {
            return const SizedBox(
              height: 30,
            );
          },
        ),
      ),
    );
  }

  Expanded buildStorySection(BuildContext context) {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.only(left: 15, top: 24),
        //color: Theme.of(context).colorScheme.secondary,
        width: double.infinity,
        child: ListView.builder(
          shrinkWrap: true,
          primary: false,
          itemBuilder: (context, index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  width: 70,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircularDisplayPicture(
                            radius: 25,
                          ),
                          Positioned(
                              right: 0,
                              bottom: 0,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(500)),
                                child: const Icon(
                                  Icons.add_circle_rounded,
                                  color: Colors.white,
                                  size: 20,
                                ),
                              ))
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Alex Linderson",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        //style: customLightTheme.primaryTextTheme.labelLarge,
                      )
                    ],
                  ),
                ),
              );
            } else {
              return Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  width: 70,
                  child: Column(
                    children: [
                      CircularDisplayPicture(
                        radius: 25,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Text(
                        "Alex Linderson",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.center,
                        //style: customLightTheme.primaryTextTheme.labelLarge,
                      )
                    ],
                  ),
                ),
              );
            }
          },
          itemCount: 30,
          scrollDirection: Axis.horizontal,
        ),
      ),
    );
  }
}
