import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:json_annotation/json_annotation.dart';

import '../../domain/entity/user_entity.dart';


part 'auth_api_model.g.dart';

final authApiModelProvider = Provider<AuthApiModel>((ref) {
  return AuthApiModel(
    fullName: '',
    email: '',
    password: '',
  );
});

@JsonSerializable()
class AuthApiModel {
  @JsonKey(name: '_id')
  final String? userId;
  final String fullName;

  final String email;
  final String? password;

  AuthApiModel({
    this.userId,
    required this.fullName,
    required this.email,
    this.password,
  });
  factory AuthApiModel.fromJson(Map<String, dynamic> json) =>
      _$AuthApiModelFromJson(json);

  Map<String, dynamic> toJson() => _$AuthApiModelToJson(this);

  UserEntity toEntity() => UserEntity(
        fullName: fullName,
        email: email,
        password: password ?? '', 
      );
  List<UserEntity> listFromJson(List<AuthApiModel> models) =>
      models.map((model) => model.toEntity()).toList();

  @override
  String toString() {
    return 'AuthApiModel(id: $userId, fullName: $fullName, email: $email, passowrd: $password,)';
  }
}
