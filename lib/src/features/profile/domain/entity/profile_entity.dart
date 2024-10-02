import 'package:enigma/src/features/profile/data/model/profile_model.dart';

class ProfileEntity {
  String? uid;
  String? name;
  String? email;
  String? phoneNumber;
  String? avatarUrl;
  DateTime? createdAt;
  DateTime? updatedAt;
  DateTime? lastSeen;
  bool? isActive;

  ProfileEntity({
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

  // Method to convert a ProfileEntity instance to a JSON object
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

  // Factory method to create a ProfileEntity instance from a JSON object
  factory ProfileEntity.fromJson(Map<String, dynamic> json) {
    return ProfileEntity(
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

  // Method to convert a ProfileEntity instance to a ProfileModel instance
  ProfileModel toModel() {
    return ProfileModel(
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
}
