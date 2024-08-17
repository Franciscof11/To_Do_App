import 'dart:convert';

class UserModel {
  final String email;
  final String password;
  UserModel({
    required this.email,
    required this.password,
  });

  UserModel copyWith({
    String? email,
    String? password,
  }) {
    return UserModel(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({
      'email': email
    });
    result.addAll({
      'password': password
    });

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
    );
  }

  factory UserModel.empty() {
    return UserModel(
      email: '',
      password: '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source));

  @override
  String toString() => 'UserModel(email: $email, password: $password)';
}
