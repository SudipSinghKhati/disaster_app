import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/router/app_route.dart';
import '../../../../core/common/snackbar/snackbar.dart';
import '../../domain/entity/news_entity.dart';
import '../../domain/use_case/news_usecase.dart';
import '../state/news_state.dart';

final newsViewModelProvider = StateNotifierProvider<NewsViewModel, NewsState>(
  (ref) => NewsViewModel(
    ref.watch(newsUsecaseProvider),
  ),
);

class NewsViewModel extends StateNotifier<NewsState> {
  final NewsUseCase newsUseCase;

  NewsViewModel(this.newsUseCase) : super(NewsState.initial()) {
    getAllNews();
  }

  Future<void> getAllNews() async {
    state = state.copyWith(isLoading: true);
    var data = await newsUseCase.getAllNews();
    //

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, news: r, error: null),
    );
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

  Future<void> addNews(NewsEntity newsEntity, BuildContext context) async {
    state = state.copyWith(isLoading: true);
    var data = await newsUseCase.addNews(newsEntity);
    data.fold((failed) {
      state = state.copyWith(isLoading: false, error: failed.error);
    }, (success) {
      state = state.copyWith(isLoading: false, error: null);

      // navigate to sign in view
      Navigator.pushNamed(context, AppRoute.uploadViews);
    });
  }

  getNewsById(String newsId) async {
    state = state.copyWith(isLoading: true);
    var data = await newsUseCase.getNewsById(newsId);
    state = state.copyWith(newsById: []);

    data.fold(
      (l) => state = state.copyWith(isLoading: false, error: l.error),
      (r) => state = state.copyWith(isLoading: false, newsById: r, error: null),
    );
  }

  Future<void> uploadImage(File file, String postId) async {
    state = state.copyWith(isLoading: true);
    var data = await newsUseCase.uploadNewsPicture(file, postId);
    data.fold(
      (l) {
        state = state.copyWith(isLoading: false, error: l.error);
      },
      (imageName) {
        state =
            state.copyWith(isLoading: false, error: null, imageName: imageName);
      },
    );
  }
}
