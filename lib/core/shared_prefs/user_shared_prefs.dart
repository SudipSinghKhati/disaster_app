import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../fetures/auth/domain/entity/user_entity.dart';
import '../failure/failure.dart';

final userSharedPrefsProvider =
    Provider<UserSharedPrefs>((ref) => UserSharedPrefs());

class UserSharedPrefs {
  late SharedPreferences _sharedPreferences;

  // set user token

  Future<Either<Failure, bool>> setUserToken({required String token}) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // set the token

      await _sharedPreferences.setString('token', token);

      // set the role

      // await _sharedPreferences.setString('role', role);

      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // get user token

  Future<Either<Failure, String?>> getUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // get the token from Shared Prefs

      final token = _sharedPreferences.getString('token');

      return right(token);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // set user entity

  Future<Either<Failure, bool>> setUserEntity(UserEntity user) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // Convert UserEntity to JSON string
      final userJson = json.encode(user.toJson());

      // Set the user JSON string in SharedPreferences
      await _sharedPreferences.setString('user', userJson);

      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // get user entity

  Future<Either<Failure, UserEntity?>> getUserEntity() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // Get the user JSON string from SharedPreferences
      final userJson = _sharedPreferences.getString('user');

      if (userJson != null) {
        // Parse the JSON string and create a UserEntity object
        final userMap = json.decode(userJson);
        final user = UserEntity.fromJson(userMap);
        return right(user);
      } else {
        return right(null);
      }
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // Delete token
  Future<Either<Failure, bool>> deleteUserToken() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();
      await _sharedPreferences.remove('token');
      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
