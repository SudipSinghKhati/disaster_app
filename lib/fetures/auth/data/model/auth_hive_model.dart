import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive/hive.dart';
import 'package:uuid/uuid.dart';

import '../../../../config/constants/hive_table_constant.dart';
import '../../domain/entity/user_entity.dart';

part 'auth_hive_model.g.dart';

final authHiveModelProvider = Provider(
  (ref) => AuthHiveModel.empty(),
);

@HiveType(typeId: HiveTableConstant.userTableId)
class AuthHiveModel {
  @HiveField(0)
  final String userId;

  @HiveField(1)
  final String fullName;

  @HiveField(2)
  final String email;

  @HiveField(3)
  final String password;

  AuthHiveModel({
    String? userId,
    required this.fullName,
    required this.email,
    required this.password,
  }) : userId = userId ?? const Uuid().v4();

  //emty constructor
  AuthHiveModel.empty()
      : this(
          userId: '',
          fullName: '',
          email: '',
          password: '',
        );

  UserEntity toEntity() => UserEntity(
      id: userId, fullName: fullName, email: email, password: password);

  //convert Entity to Hive Object
  AuthHiveModel toHiveModel(UserEntity entity) => AuthHiveModel(
      userId: const Uuid().v4(),
      fullName: entity.fullName,
      email: entity.email,
      password: entity.password);

  //covert Entity List to Hice List
  List<AuthHiveModel> toHiveModelList(List<UserEntity> entities) =>
      entities.map((entity) => toHiveModel(entity)).toList();

  @override
  String toString() {
    return 'userId: $userId, fullName:$fullName,  email: $email, password: $password';
  }
}
