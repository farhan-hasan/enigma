import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';
import 'package:enigma/src/features/story/domain/entity/story_entity.dart';

class StoryModel {
  String? content;
  String? id;
  String? uid;
  String? mediaLink;
  DateTime? timestamp;
  String? type;

  StoryModel({
    this.content,
    this.id,
    this.uid,
    this.mediaLink,
    this.timestamp,
    this.type,
  });

  // Convert StoryModel to JSON
  Map<String, dynamic> toJson() {
    return {
      'content': content,
      'id': id,
      'uid': uid,
      'mediaLink': mediaLink,
      'timestamp': timestamp != null ? Timestamp.fromDate(timestamp!) : null,
      'type': type?.toString(), // Assuming MediaType is an enum
    };
  }

  // Create StoryModel from JSON
  factory StoryModel.fromJson(Map<String, dynamic> json) {
    return StoryModel(
      content: json['content'] as String?,
      id: json['id'] as String?,
      uid: json['uid'] as String?,
      mediaLink: json['mediaLink'] as String?,
      timestamp: json['timestamp'] != null
          ? (json['timestamp'] as Timestamp).toDate()
          : null,
      //type: json['type'] != null ? MediaType.values.byName(json['type']) : null,
      type: json['type'],
    );
  }

  // Convert StoryModel to StoryEntity
  StoryEntity toEntity() {
    return StoryEntity(
        content: content,
        id: id,
        uid: uid,
        mediaLink: mediaLink,
        timestamp: timestamp,
        type: MediaType.values.byName(type ?? "text"));
  }

  // Create StoryModel from StoryEntity
  factory StoryModel.fromEntity(StoryEntity entity) {
    return StoryModel(
      content: entity.content,
      id: entity.id,
      uid: entity.uid,
      mediaLink: entity.mediaLink,
      timestamp: entity.timestamp,
      type: entity.type?.name,
    );
  }
}
