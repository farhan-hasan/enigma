import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/story/data/model/story_model.dart';

class StoryEntity {
  String? content;
  String? id;
  String? mediaLink;
  String? uid;
  DateTime? timestamp;
  MediaType? type;

  StoryEntity({
    this.content,
    this.id,
    this.uid,
    this.mediaLink,
    this.timestamp,
    this.type,
  });

  // Convert StoryEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'id': id,
      'uid': uid,
      'mediaLink': mediaLink,
      'timestamp': timestamp?.toIso8601String(),
      'type': type?.name, // Assuming MediaType is an enum
    };
  }

  // Create StoryEntity from JSON
  factory StoryEntity.fromJson(Map<String, dynamic> json) {
    return StoryEntity(
      content: json['content'] as String?,
      id: json['id'] as String?,
      uid: json['uid'] as String?,
      mediaLink: json['mediaLink'] as String?,
      timestamp: json['timestamp'] != null
          ? DateTime.parse(json['timestamp'] as String)
          : null,
      type: json['type'] != null ? MediaType.values.byName(json['type']) : null,
      //type: json['type'] != null ? MediaType.values[json['type']] : null,
    );
  }

  // Convert StoryEntity to StoryModel
  StoryModel toModel() {
    return StoryModel(
      content: content,
      id: id,
      uid: uid,
      mediaLink: mediaLink,
      timestamp: timestamp,
      type: type?.name,
    );
  }

  // Create StoryEntity from StoryModel
  factory StoryEntity.fromModel(StoryModel model) {
    return StoryEntity(
      content: model.content,
      id: model.id,
      uid: model.uid,
      mediaLink: model.mediaLink,
      timestamp: model.timestamp,
      type: MediaType.values
          .firstWhere((e) => e.name.split('.').last == model.type),
    );
  }
}
