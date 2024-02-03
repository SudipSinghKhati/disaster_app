import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/common/snackbar/snackbar.dart';
import '../../domain/entity/news_entity.dart';
import '../../domain/use_case/news_usecase.dart';
import '../state/news_state.dart';

final newsGetMyNewsViewModelProvider =
    StateNotifierProvider<NewsGetMyNewsViewModel, NewsState>(
  (ref) => NewsGetMyNewsViewModel(
    ref.watch(newsUsecaseProvider),
  ),
);

class NewsGetMyNewsViewModel extends StateNotifier<NewsState> {
  final NewsUseCase newsUseCase;

  NewsGetMyNewsViewModel(this.newsUseCase) : super(NewsState.initial()) {
    getMyNews();
  }

  Future<void> getMyNews() async {
    state = state.copyWith(isLoading: true);
    var data = await newsUseCase.getMyNews();

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, news: r, error: null),
    );
  }

  updateNews(NewsEntity news, String newsId) async {
    state = state.copyWith(isLoading: true);
    var data = await newsUseCase.updateNews(news, newsId);
    state = state.copyWith(isLoading: false);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, error: null),
    );
  }

  Future<void> deleteNews(BuildContext context, String newsId) async {
    state.copyWith(isLoading: true);
    var data = await newsUseCase.deleteNews(newsId);

    data.fold(
      (l) {
        showSnackBar(message: l.error, context: context, color: Colors.red);

        state = state.copyWith(isLoading: false, error: l.error);
      },
      (r) {
        state = state.copyWith(isLoading: false, error: null);
      },
    );
  }
}
