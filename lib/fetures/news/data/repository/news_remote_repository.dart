import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../../domain/entity/news_entity.dart';
import '../../domain/repository/news_repositary.dart';
import '../data_source/news_remote_data_source.dart';

final newsRemoteRepositoryProvider = Provider<IRoomRepository>((ref) {
  return NewsRemoteRepository(
    ref.read(newsRemoteDataSourceProvider),
  );
});

class NewsRemoteRepository implements IRoomRepository {
  final NewsRemoteDataSource _newsRemoteDataSource;

  NewsRemoteRepository(this._newsRemoteDataSource);

  @override
  Future<Either<Failure, bool>> addNews(NewsEntity news) {
    return _newsRemoteDataSource.addNews(news);
  }

  @override
  Future<Either<Failure, bool>> deleteNews(String newsId) {
    return _newsRemoteDataSource.deleteNews(newsId);
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getAllNews() {
    return _newsRemoteDataSource.getAllNews();
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getMyNews() {
    return _newsRemoteDataSource.getMyNews();
  }

  @override
  Future<Either<Failure, String>> uploadNewsPicture(File file, String postId) {
    return _newsRemoteDataSource.uploadNewsPicture(file, postId);
  }

  @override
  Future<Either<Failure, List<NewsEntity>>> getNewsById(String newsId) {
    return _newsRemoteDataSource.getNewsById(newsId);
  }

  @override
  Future<Either<Failure, bool>> updateNews(NewsEntity news, String newsId) {
    return _newsRemoteDataSource.updateNews(news, newsId);
  }
}
