import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';

class ChatRequestModel {
  String? senderUid;
  String? receiverUid;
  String? status;
  DateTime? acceptedAt;

  ChatRequestModel({
    this.senderUid,
    this.receiverUid,
    this.status,
    this.acceptedAt,
  });

  // Factory constructor to create an instance from JSON data
  factory ChatRequestModel.fromJson(Map<String, dynamic> json) {
    return ChatRequestModel(
      senderUid: json['senderUid'] as String?,
      receiverUid: json['receiverUid'] as String?,
      status: json['status'] as String?,
      acceptedAt: json['acceptedAt'] != null
          ? DateTime.parse(json['acceptedAt'])
          : null,
    );
  }

  // Method to convert the instance into a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'status': status,
      'acceptedAt': acceptedAt?.toIso8601String(), // Convert DateTime to String
    };
  }

  // Convert model to entity
  ChatRequestEntity toEntity() {
    return ChatRequestEntity(
      senderUid: this.senderUid,
      receiverUid: this.receiverUid,
      status: this.status,
      acceptedAt: this.acceptedAt,
    );
  }
}
