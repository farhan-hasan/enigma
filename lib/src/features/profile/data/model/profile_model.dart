import 'package:enigma/src/features/profile/domain/entity/profile_entity.dart';

class ProfileModel {
  String? uid;
  String? name;
  String? email;
  String? phoneNumber;
  String? avatarUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? lastSeen;
  bool? isActive;

  ProfileModel({
    this.uid,
    this.name,
    this.email,
    this.phoneNumber,
    this.avatarUrl,
    this.createdAt,
    this.updatedAt,
    this.lastSeen,
    this.isActive,
  });

  // Factory method to create a ProfileModel instance from a JSON object
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      uid: json['uid'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      avatarUrl: json['avatarUrl'],
      createdAt: json['createdAt'] != null
          ? DateTime.tryParse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.tryParse(json['updatedAt'])
          : null,
      lastSeen:
          json['lastSeen'] != null ? DateTime.tryParse(json['lastSeen']) : null,
      isActive: json['isActive'],
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
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'lastSeen': lastSeen?.toIso8601String(),
      'isActive': isActive,
    };
  }

  // Method to update user details
  void updateUser({
    String? name,
    String? email,
    String? phoneNumber,
    String? avatarUrl,
  }) {
    this.name = name ?? this.name;
    this.email = email ?? this.email;
    this.phoneNumber = phoneNumber ?? this.phoneNumber;
    this.avatarUrl = avatarUrl ?? this.avatarUrl;
    this.updatedAt = DateTime.now();
  }

  // Convert ProfileModel to ProfileEntity
  ProfileEntity toEntity() {
    return ProfileEntity(
      uid: uid,
      name: name,
      email: email,
      phoneNumber: phoneNumber,
      avatarUrl: avatarUrl,
      createdAt: createdAt,
      updatedAt: updatedAt,
      lastSeen: lastSeen,
      isActive: isActive,
    );
  }

  // Factory method to create a ProfileModel instance from a ProfileEntity
  factory ProfileModel.fromEntity(ProfileEntity entity) {
    return ProfileModel(
      uid: entity.uid,
      name: entity.name,
      email: entity.email,
      phoneNumber: entity.phoneNumber,
      avatarUrl: entity.avatarUrl,
      createdAt: entity.createdAt,
      updatedAt: entity.updatedAt,
      lastSeen: entity.lastSeen,
      isActive: entity.isActive,
    );
  }

  @override
  String toString() {
    return 'ProfileModel{uid: $uid, name: $name, email: $email, phoneNumber: $phoneNumber, avatarUrl: $avatarUrl, createdAt: $createdAt, updatedAt: $updatedAt, lastSeen: $lastSeen, isActive: $isActive}';
  }
}
