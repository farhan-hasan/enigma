import 'package:enigma/src/features/chat_request/data/model/chat_request_model.dart';

enum Status { pending, accepted, rejected, blocked }

class ChatRequestEntity {
  String? senderUid;
  String? receiverUid;
  String? status;
  DateTime? acceptedAt;

  ChatRequestEntity({
    this.senderUid,
    this.receiverUid,
    this.status,
    this.acceptedAt,
  });

  // Factory constructor to create an entity from JSON data
  factory ChatRequestEntity.fromJson(Map<String, dynamic> json) {
    return ChatRequestEntity(
      senderUid: json['senderUid'] as String?,
      receiverUid: json['receiverUid'] as String?,
      status: json['status'] as String?,
      acceptedAt: json['acceptedAt'] != null
          ? DateTime.parse(json['acceptedAt'])
          : null,
    );
  }

  // Method to convert the entity into a JSON Map
  Map<String, dynamic> toJson() {
    return {
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'status': status,
      'acceptedAt': acceptedAt?.toIso8601String(), // Convert DateTime to String
    };
  }

  // Convert entity to model
  ChatRequestModel toModel() {
    return ChatRequestModel(
      senderUid: this.senderUid,
      receiverUid: this.receiverUid,
      status: this.status,
      acceptedAt: this.acceptedAt,
    );
  }
}
