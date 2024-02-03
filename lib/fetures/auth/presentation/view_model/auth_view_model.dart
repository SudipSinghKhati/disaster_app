import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


import '../../../../config/router/app_route.dart';
import '../../../../core/common/snackbar/snackbar.dart';
import '../../domain/use_case/auth_usecase.dart';
import '../state/auth_state.dart';

final authViewModelProvider =
    StateNotifierProvider<AuthViewModel, AuthState>((ref) {
  return AuthViewModel(
    ref.watch(authUseCaseProvider),
  );
});

class AuthViewModel extends StateNotifier<AuthState> {
  final AuthUseCase _authUseCase;

  AuthViewModel(this._authUseCase) : super(AuthState(isLoading: false));

  Future<void> registerUser(BuildContext context, user) async {
    state = state.copyWith(isLoading: true);
    var data = await _authUseCase.registerUser(user);
    data.fold(
      (failure) {
        state = state.copyWith(
          isLoading: false,
          error: failure.error,
        );
        showSnackBar(context: context, message: failure.error);
      },
      (success) => state = state.copyWith(
        isLoading: false,
        error: null,
      ),
    );
  }

  Future<void> loginUser(
      BuildContext context, String email, String password) async {
    state = state.copyWith(isLoading: true);

    var data = await _authUseCase.loginUser(email, password);
    data.fold(
      (failure) {
        state = state.copyWith(isLoading: false, error: failure.error);
        showSnackBar(context: context, message: failure.error);
      },
      (success) {
        state = state.copyWith(isLoading: false, error: null);
        Future.delayed(const Duration(milliseconds: 2000), () {
          showSnackBar(context: context, message: "Logging In..");
        });

        Navigator.popAndPushNamed(context, AppRoute.dashboardRoute);
      },
    );
  }
}
