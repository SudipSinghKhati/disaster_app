import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/constants/api_endipoint.dart';
import '../../../../core/failure/failure.dart';
import '../../../../core/network/remote/http_service.dart';
import '../../../../core/shared_prefs/user_shared_prefs.dart';
import '../../domain/entity/news_entity.dart';
import '../dto/get_all_news_dto.dart';
import '../dto/get_my_news_dto.dart';
import '../model/news_api_model.dart';

final newsRemoteDataSourceProvider = Provider(
  (ref) => NewsRemoteDataSource(
    dio: ref.read(httpServiceProvider),
    newsApiModel: ref.read(newsApiModelProvider),
    userSharedPrefs: ref.read(userSharedPrefsProvider),
  ),
);

class NewsRemoteDataSource {
  late final Dio dio;
  late final NewsApiModel newsApiModel;
  late final UserSharedPrefs userSharedPrefs;

  NewsRemoteDataSource({
    required this.dio,
    required this.newsApiModel,
    required this.userSharedPrefs,
  });

  Future<Either<Failure, bool>> addNews(NewsEntity news) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);

      Response response = await dio.post(
        ApiEndpoints.addNews,
        data: {
          "title": news.title,
          "location": news.location,
          "description": news.description,
          "image": news.image,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 201) {
        // save the post id
        NewsEntity.postId = response.data['id'];

        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['error'].toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }

  Future<Either<Failure, List<NewsEntity>>> getAllNews() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);

      Response response = await dio.get(
        ApiEndpoints.getAllNews,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        GetAllNewsDTO newsDto = GetAllNewsDTO.fromJson(response.data);

        return Right(newsApiModel.toEntityList(newsDto.data));
      } else {
        return Left(
          Failure(
            error: response.data['error'].toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }

  // Upload image using multipart
  Future<Either<Failure, String>> uploadNewsPicture(
    File image,
    String postId,
  ) async {
    try {
      String? token;
      await userSharedPrefs
          .getUserToken()
          .then((value) => value.fold((l) => null, (r) => token = r!));
      String fileName = image.path.split('/').last;
      FormData formData = FormData.fromMap(
        {
          'NewsImages': await MultipartFile.fromFile(
            image.path,
            filename: fileName,
          ),
        },
      );

      Response response = await dio.post(
        ApiEndpoints.uploadImage + postId,
        options: Options(headers: {
          'Authorization': 'Bearer $token',
        }),
        data: formData,
      );

      return Right(response.data["data"]);
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
          statusCode: e.response?.statusCode.toString() ?? '0',
        ),
      );
    }
  }

  Future<Either<Failure, bool>> updateNews(
      NewsEntity news, String newsId) async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.put(
        ApiEndpoints.updateNews(newsId),
        data: {
          "title": news.title,
          "description": news.description,
          "location": news.location,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 204) {
        // Profile edited successfully
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: 'Failed to update News. Please try again.',
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, bool>> deleteNews(String newsId) async {
    try {
      String? token;

      var data = await userSharedPrefs.getUserToken();
      data.fold(
        (l) => token = null,
        (r) => token = r!,
      );

      var response = await dio.delete(
        ApiEndpoints.deleteNews(newsId),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      // var response = http.delete(Uri.parse(ApiEndpoints.baseUrl+ ''))

      if (response.statusCode == 200) {
        return const Right(true);
      } else {
        return Left(
          Failure(
            error: response.data['error'],
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(
        Failure(
          error: e.error.toString(),
        ),
      );
    }
  }

  Future<Either<Failure, List<NewsEntity>>> getNewsById(String newsId) async {
    try {
      String? token;
      await userSharedPrefs.getUserToken().then(
            (value) => value.fold((l) => null, (r) => token = r),
          );

      var response = await dio.get(
        ApiEndpoints.getNewsById(newsId),
        options: Options(
          headers: {'Authorization': 'Bearer $token'},
        ),
      );
      if (response.statusCode == 200) {
        GetAllNewsDTO newsDto = GetAllNewsDTO.fromJson(response.data);

        return Right(newsApiModel.toEntityList(newsDto.data));
      } else {
        return Left(
          Failure(
            error: response.data['error'].toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }

  Future<Either<Failure, List<NewsEntity>>> getMyNews() async {
    try {
      String? token;
      var data = await userSharedPrefs.getUserToken();
      data.fold((l) => token = null, (r) => token = r!);

      Response response = await dio.get(
        ApiEndpoints.getMyNews,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200) {
        GetMyNewsDTO newsDto = GetMyNewsDTO.fromJson(response.data);

        return Right(newsApiModel.toEntityList(newsDto.data));
      } else {
        return Left(
          Failure(
            error: response.data['error'].toString(),
            statusCode: response.statusCode.toString(),
          ),
        );
      }
    } on DioException catch (e) {
      return Left(Failure(
        error: e.error.toString(),
        statusCode: e.response?.statusCode.toString() ?? '0',
      ));
    }
  }
}
