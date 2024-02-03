import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/Provider/internet_connection.dart';
import '../../../../core/failure/failure.dart';
import '../../data/repository/news_remote_repository.dart';
import '../entity/news_entity.dart';

final newsRepositoryProvider = Provider<IRoomRepository>((ref) {
  // ignore: unused_local_variable
  final internetStatus = ref.watch(connectivityStatusProvider);

  return ref.watch(newsRemoteRepositoryProvider);
});

abstract class IRoomRepository {
  Future<Either<Failure, List<NewsEntity>>> getAllNews();
  Future<Either<Failure, List<NewsEntity>>> getMyNews();
  Future<Either<Failure, List<NewsEntity>>> getNewsById(String newsId);
  Future<Either<Failure, bool>> addNews(NewsEntity news);

  Future<Either<Failure, bool>> updateNews(NewsEntity news, String newsId);
  Future<Either<Failure, bool>> deleteNews(String newsId);
  Future<Either<Failure, String>> uploadNewsPicture(File file, String postId);
}
