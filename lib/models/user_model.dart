import 'dart:convert';

class UserModel {
  final String fullName;
  final String email;
  final String phoneNumber;
  final String password;

  UserModel({
    required this.fullName,
    required this.email,
    required this.phoneNumber,
    required this.password,
  });

  @override
  String toString() {
    return 'UserModel(fullName: $fullName, email: $email, phoneNumber: $phoneNumber)';
  }

  // Convert a map to a UserModel instance
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      fullName: map['fullName'],
      email: map['email'],
      phoneNumber: map['phoneNumber'],
      password: map['password'],
    );
  }

  // Convert the UserModel instance to a JSON string
  String toJson() => json.encode(toMap());

  // Convert a JSON string to a UserModel instance
  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  // Convert UserModel to Map<String, dynamic>
  Map<String, dynamic> toMap() {
    return {
      'fullName': fullName,
      'email': email,
      'phoneNumber': phoneNumber,
      'password': password,
    };
  }
}
