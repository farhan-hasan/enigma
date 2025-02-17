class CallModel {
  String? token;
  String? channelId;
  int? uid;
  String? receiverUid;
  String? receiverName;
  String? receiverAvatar;
  String? receiverToken;

  String? senderUid;
  String? senderName;
  String? senderAvatar;

  CallModel(
      {this.token,
      this.channelId,
      this.uid,
      this.receiverAvatar,
      this.receiverName,
      this.receiverUid,
      this.senderUid,
      this.senderName,
      this.senderAvatar,
      this.receiverToken});

  // Convert a CallModel object to a JSON map
  Map<String, dynamic> toJson() {
    return {
      'token': token,
      'channelId': channelId,
      'uid': uid,
      'receiverUid': receiverUid,
      'receiverName': receiverName,
      'receiverAvatar': receiverAvatar,
      'senderUid': senderUid,
      'senderName': senderName,
      'senderAvatar': senderAvatar,
    };
  }

  // Create a CallModel object from a JSON map
  factory CallModel.fromJson(Map<String, dynamic> json) {
    return CallModel(
      token: json['token'] as String?,
      channelId: json['channelId'] as String?,
      uid: json['uid'] as int?,
      receiverUid: json['receiverUid'] as String?,
      receiverName: json['receiverName'] as String?,
      receiverAvatar: json['receiverAvatar'] as String?,
      senderUid: json['senderUid'] as String?,
      senderName: json['senderName'] as String?,
      senderAvatar: json['senderAvatar'] as String?,
    );
  }
}
