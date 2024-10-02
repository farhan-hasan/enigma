class ProfileModel {
  String uid;
  String name;
  String email;
  String phoneNumber;
  String avatarUrl;
  DateTime createdAt;
  DateTime updatedAt;
  DateTime lastSeen;
  bool isActive;

  ProfileModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.avatarUrl,
    required this.createdAt,
    required this.updatedAt,
    required this.lastSeen,
    required this.isActive,
  });

  // Factory method to create a ProfileModel instance from a JSON object
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      uid: json['uid'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      avatarUrl: json['avatarUrl'] ?? '',
      createdAt:
          DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime(2024, 1, 1),
      updatedAt:
          DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime(2024, 1, 1),
      lastSeen:
          DateTime.tryParse(json['lastSeen'] ?? '') ?? DateTime(2024, 1, 1),
      isActive: json['isActive'] ?? false,
    );
  }

  // Method to convert a ProfileModel instance to a JSON object
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'avatarUrl': avatarUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'lastSeen': lastSeen.toIso8601String(),
      'isActive': isActive,
    };
  }

  // Method to update user details
  void updateUser({
    required String name,
    required String email,
    required String phoneNumber,
    required String avatarUrl,
  }) {
    this.name = name;
    this.email = email;
    this.phoneNumber = phoneNumber;
    this.avatarUrl = avatarUrl;
    this.updatedAt = DateTime.now();
  }

  @override
  String toString() {
    return 'ProfileModel{uid: $uid, name: $name, email: $email, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl, createdAt: $createdAt, updatedAt: $updatedAt, lastSeen: $lastSeen, isActive: $isActive}';
  }
}
