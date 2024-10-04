import 'package:enigma/src/features/chat_request/data/model/chat_request_model.dart';

class ChatRequestEntity {
  String? senderUid;
  String? receiverUid;
  bool? isAccepted;
  DateTime? acceptedAt;

  ChatRequestEntity(
      {this.senderUid, this.receiverUid, this.isAccepted, this.acceptedAt});

  // fromJson method
  factory ChatRequestEntity.fromJson(Map<String, dynamic> json) {
    return ChatRequestEntity(
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

  // toModel method to convert ChatRequestEntity to ChatRequestModel
  ChatRequestModel toModel() {
    return ChatRequestModel(
      senderUid: this.senderUid,
      receiverUid: this.receiverUid,
      isAccepted: this.isAccepted,
      acceptedAt: this.acceptedAt,
    );
  }
}
