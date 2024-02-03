

import '../../domain/entity/news_entity.dart';

class NewsState {
  final bool isLoading;
  final List<NewsEntity> news;
  final List<NewsEntity> newsById;
  final String? error;
  final String? imageName;

  NewsState({
    required this.isLoading,
    required this.news,
    required this.newsById,
    this.error,
    this.imageName,
  });

  factory NewsState.initial() {
    return NewsState(
      isLoading: false,
      news: [],
      newsById: [],
      error: null,
      imageName: null,
    );
  }

  NewsState copyWith({
    bool? isLoading,
    List<NewsEntity>? news,
    List<NewsEntity>? newsById,
    String? error,
    String? imageName,
  }) {
    return NewsState(
      isLoading: isLoading ?? this.isLoading,
      newsById: newsById ?? this.newsById,
      news: news ?? this.news,
      error: error ?? this.error,
      imageName: imageName ?? this.imageName,
    );
  }
}
