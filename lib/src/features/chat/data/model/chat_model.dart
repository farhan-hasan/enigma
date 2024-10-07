import 'package:enigma/src/features/chat/domain/entity/chat_entity.dart';

class ChatModel {
  String? id;
  String? sender;
  String? receiver;
  String? content;
  DateTime? timestamp;
  String? mediaLink;
  String? type;

  ChatModel({
    this.id,
    this.sender,
    this.receiver,
    this.content,
    this.timestamp,
    this.mediaLink,
    this.type,
  });

  // fromJson method to deserialize a JSON object into a ChatModel
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json['id'] as String?,
      sender: json['sender'] as String?,
      receiver: json['receiver'] as String?,
      content: json['content'] as String?,
      timestamp:
          json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
      mediaLink: json['mediaLink'] as String?,
      type: json['type'],
    );
  }

  // toJson method to serialize a ChatModel into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'timestamp': timestamp?.toIso8601String(),
      'mediaLink': mediaLink,
      'type': type,
    };
  }

  // toEntity method to convert ChatModel to ChatEntity
  ChatEntity toEntity() {
    return ChatEntity(
        id: id,
        sender: sender,
        receiver: receiver,
        content: content,
        timestamp: timestamp,
        mediaLink: mediaLink,
        /*type: MediaType.values
          .firstWhereOrNull((e) => e.toString().split(".").last == type),*/
        type: MediaType.values
            .firstWhere((e) => e.toString().split(".").last == type));
  }

  // fromEntity method to create ChatModel from ChatEntity
  factory ChatModel.fromEntity(ChatEntity entity) {
    return ChatModel(
      id: entity.id,
      sender: entity.sender,
      receiver: entity.receiver,
      content: entity.content,
      timestamp: entity.timestamp,
      mediaLink: entity.mediaLink,
      type: entity.type?.name,
    );
  }
}
