import 'package:enigma/src/features/chat/data/model/chat_model.dart';

enum MediaType {
  text,
  image,
  video,
  file,
  voice,
}

class ChatEntity {
  String? id;
  String? sender;
  String? receiver;
  String? content;
  DateTime? timestamp;
  String? mediaLink;
  MediaType? type;

  ChatEntity({
    this.id,
    this.sender,
    this.receiver,
    this.content,
    this.timestamp,
    this.mediaLink,
    this.type,
  });

  // fromJson method to deserialize a JSON object into a ChatEntity
  factory ChatEntity.fromJson(Map<String, dynamic> json) {
    return ChatEntity(
      id: json['id'] as String?,
      sender: json['sender'] as String?,
      receiver: json['receiver'] as String?,
      content: json['content'] as String?,
      timestamp:
          json['timestamp'] != null ? DateTime.parse(json['timestamp']) : null,
      mediaLink: json['mediaLink'] as String?,
      type: json['type'] != null ? MediaType.values[json['type']] : null,
    );
  }

  // toJson method to serialize a ChatEntity into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'sender': sender,
      'receiver': receiver,
      'content': content,
      'timestamp': timestamp?.toIso8601String(),
      'mediaLink': mediaLink,
      'type': type?.name,
    };
  }

  // toModel method to convert ChatEntity to ChatModel
  ChatModel toModel() {
    return ChatModel(
      id: id,
      sender: sender,
      receiver: receiver,
      content: content,
      timestamp: timestamp,
      mediaLink: mediaLink,
      type: type?.name,
    );
  }

  // fromModel method to create ChatEntity from ChatModel
  factory ChatEntity.fromModel(ChatModel model) {
    return ChatEntity(
      id: model.id,
      sender: model.sender,
      receiver: model.receiver,
      content: model.content,
      timestamp: model.timestamp,
      mediaLink: model.mediaLink,
      type: MediaType.values
          .firstWhere((e) => e.name.split('.').last == model.type),
    );
  }
}
