class MessageEntity {
  int? id;
  String? message;

  MessageEntity({
    this.id,
    this.message,
  });

  // Factory method to create a LoginEntity from JSON
  factory MessageEntity.fromJson(Map<String, dynamic> json) {
    return MessageEntity(
      id: json['id'] as int?,
      message: json['message'] as String?,
    );
  }

  // Method to convert LoginEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
    };
  }
}
