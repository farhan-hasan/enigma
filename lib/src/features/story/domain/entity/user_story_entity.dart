import 'package:enigma/src/features/story/data/model/user_story_model.dart';
import 'package:enigma/src/features/story/domain/entity/story_entity.dart';

class UserStoryEntity {
  String? name;
  String? uid;
  List<StoryEntity>? storyList;

  UserStoryEntity({this.name, this.uid, this.storyList});

  // Convert Entity to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'StoryList': storyList,
    };
  }

  // Create Entity from JSON
  factory UserStoryEntity.fromJson(Map<String, dynamic> json) {
    return UserStoryEntity(
      name: json['name'] as String?,
      uid: json['uid'] as String?,
      storyList: json['StoryList'] as List<StoryEntity>?,
    );
  }

  // Convert Entity to Model
  UserStoryModel toModel() {
    return UserStoryModel(
      name: name,
      uid: uid,
      storyList: storyList,
    );
  }

  // Create Entity from Model
  factory UserStoryEntity.fromModel(UserStoryModel model) {
    return UserStoryEntity(
      name: model.name,
      uid: model.uid,
      storyList: model.storyList,
    );
  }
}
