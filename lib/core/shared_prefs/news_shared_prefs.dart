import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../fetures/news/domain/entity/news_entity.dart';
import '../failure/failure.dart';

class NewsSharedPrefs {
  late SharedPreferences _sharedPreferences;

  //set Newsentity
  Future<Either<Failure, bool>> setRoomEntity(NewsEntity news) async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // Convert UserEntity to JSON string
      final roomJson = json.encode(news.toJson());

      // Set the user JSON string in SharedPreferences
      await _sharedPreferences.setString('room', roomJson);

      return right(true);
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }

  // get news entity

  Future<Either<Failure, NewsEntity?>> getNewsEntity() async {
    try {
      _sharedPreferences = await SharedPreferences.getInstance();

      // Get the user JSON string from SharedPreferences
      final newsJson = _sharedPreferences.getString('room');

      if (newsJson != null) {
        // Parse the JSON string and create a UserEntity object
        final newsMap = json.decode(newsJson);
        final news = NewsEntity.fromJson(newsMap);
        return right(news);
      } else {
        return right(null);
      }
    } catch (e) {
      return left(Failure(error: e.toString()));
    }
  }
}
