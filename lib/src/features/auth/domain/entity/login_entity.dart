class LoginEntity {
  int? id;
  String? name;

  LoginEntity({
    this.id,
    this.name,
  });

  // Factory method to create a LoginEntity from JSON
  factory LoginEntity.fromJson(Map<String, dynamic> json) {
    return LoginEntity(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  // Method to convert LoginEntity to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
