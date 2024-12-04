// lib/models/userModel.dart

class UserModel {
  final String id;
  final String name;
  final String email;
  final String gender;
  final String phoneNumber;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    required this.gender,
    required this.phoneNumber,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['user']['id'],
      name: json['user']['name'],
      email: json['user']['email'],
      gender: json['user']['gender'],
      phoneNumber: json['user']['phoneNumber'],
    );
  }
}
