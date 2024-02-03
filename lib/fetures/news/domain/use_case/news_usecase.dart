import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/failure/failure.dart';
import '../entity/news_entity.dart';
import '../repository/news_repositary.dart';

final newsUsecaseProvider = Provider<NewsUseCase>(
  (ref) => NewsUseCase(
    ref.watch(newsRepositoryProvider),
  ),
);

class NewsUseCase {
  final IRoomRepository _newsRepository;

  NewsUseCase(this._newsRepository);

  Future<Either<Failure, List<NewsEntity>>> getAllNews() {
    return _newsRepository.getAllNews();
  }

  Future<Either<Failure, List<NewsEntity>>> getMyNews() {
    return _newsRepository.getMyNews();
  }

  Future<Either<Failure, List<NewsEntity>>> getNewsById(String newsId) {
    return _newsRepository.getNewsById(newsId);
  }

  Future<Either<Failure, bool>> addNews(NewsEntity news) {
    return _newsRepository.addNews(news);
  }

  Future<Either<Failure, bool>> updateNews(NewsEntity news, String newsId) {
    return _newsRepository.updateNews(news, newsId);
  }

  Future<Either<Failure, bool>> deleteNews(String newsId) {
    return _newsRepository.deleteNews(newsId);
  }

  Future<Either<Failure, String>> uploadNewsPicture(
      File file, String postId) async {
    return await _newsRepository.uploadNewsPicture(file, postId);
  }
}
