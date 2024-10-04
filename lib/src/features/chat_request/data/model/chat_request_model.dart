import 'package:enigma/src/features/chat_request/domain/entity/chat_request_entity.dart';

class ChatRequestModel {
  String? senderUid;
  String? receiverUid;
  bool? isAccepted;
  DateTime? acceptedAt;

  ChatRequestModel(
      {this.senderUid, this.receiverUid, this.isAccepted, this.acceptedAt});

  // fromJson method
  factory ChatRequestModel.fromJson(Map<String, dynamic> json) {
    return ChatRequestModel(
      senderUid: json['senderUid'] as String?,
      receiverUid: json['receiverUid'] as String?,
      isAccepted: json['isAccepted'] as bool?,
      acceptedAt: json['acceptedAt'] != null
          ? DateTime.parse(json['acceptedAt'] as String)
          : null,
    );
  }

  // toJson method
  Map<String, dynamic> toJson() {
    return {
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'isAccepted': isAccepted,
      'acceptedAt': acceptedAt?.toIso8601String(),
    };
  }

  // toEntity method to convert ChatRequestModel to ChatRequestEntity
  ChatRequestEntity toEntity() {
    return ChatRequestEntity(
      senderUid: this.senderUid,
      receiverUid: this.receiverUid,
      isAccepted: this.isAccepted,
      acceptedAt: this.acceptedAt,
    );
  }
}
