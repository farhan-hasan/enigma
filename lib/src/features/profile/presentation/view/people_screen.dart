import 'dart:convert';

import 'package:enigma/src/core/utils/extension/context_extension.dart';
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
    WidgetsBinding.instance.addPostFrameCallback((t) {
      ref.read(peopleProvider.notifier).readAllPeople();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final PeopleGeneric peopleController = ref.watch(peopleProvider);
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // People list
            buildPeopleSection(context, peopleController)
          ],
        ),
      ),
    );
  }

  Widget buildPeopleSection(
      BuildContext context, PeopleGeneric peopleController) {
    if (peopleController.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Expanded(
        child: Container(
          padding: const EdgeInsets.only(top: 20),
          //color: Colors.grey,
          child: ListView.separated(
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
                          SizedBox(
                            width: context.width / 1.7,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  peopleController.listOfPeople[index].name ??
                                      "",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                    peopleController
                                            .listOfPeople[index].createdAt
                                            .toString() ??
                                        "",
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style:
                                        Theme.of(context).textTheme.labelSmall)
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      SizedBox(
                          width: 30,
                          height: 30,
                          child: IconButton(
                              onPressed: () {}, icon: Icon(Icons.add)))
                    ],
                  ),
                ),
              );
            },
            itemCount: peopleController.listOfPeople.length,
            separatorBuilder: (BuildContext context, int index) {
              return const SizedBox(
                height: 30,
              );
            },
          ),
        ),
      );
    }
  }
}
