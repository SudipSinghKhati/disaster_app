import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? id;
  final String fullName;
  final String email;
  final String password;

  const UserEntity({
    this.id,
    required this.fullName,
    required this.email,
    required this.password,
  });
  static String userId = '';
  @override
  List<Object?> get props => [id, fullName, email, password];

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'email': email,
      'password': password,
    };
  }

  static UserEntity fromJson(Map<String, dynamic> json) {
    return UserEntity(
      id: json['id'],
      fullName: json['fullName'],
      email: json['email'],
      password: json['password'],
    );
  }
}
