import 'package:enigma/src/features/story/domain/entity/story_entity.dart';
import 'package:enigma/src/features/story/domain/entity/user_story_entity.dart';

class UserStoryModel {
  String? name;
  String? uid;
  List<StoryEntity>? storyList;

  UserStoryModel({this.name, this.uid, this.storyList});

  // Convert Model to JSON
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'uid': uid,
      'StoryList': storyList,
    };
  }

  // Create Model from JSON
  factory UserStoryModel.fromJson(Map<String, dynamic> json) {
    return UserStoryModel(
      name: json['name'] as String?,
      uid: json['uid'] as String?,
      storyList: json['StoryList'] as List<StoryEntity>?,
    );
  }

  // Convert Model to Entity
  UserStoryEntity toEntity() {
    return UserStoryEntity(
      name: name,
      uid: uid,
      storyList: storyList,
    );
  }

  // Create Model from Entity
  factory UserStoryModel.fromEntity(UserStoryEntity entity) {
    return UserStoryModel(
      name: entity.name,
      uid: entity.uid,
      storyList: entity.storyList,
    );
  }
}
