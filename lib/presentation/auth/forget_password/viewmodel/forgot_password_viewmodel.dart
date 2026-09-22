import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/api_clients.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/sources/remote/auth_api_service.dart';

final forgotPasswordViewModelProvider =
    StateNotifierProvider<ForgotPasswordView, ForgotPasswordState>(
      (ref) => ForgotPasswordView(
        repository: AuthRepository(
          remoteSource: AuthApiService(apiClient: ApiClient()),
        ),
      ),
    );

class ForgotPasswordView extends StateNotifier<ForgotPasswordState> {
  final AuthRepository repository;

  ForgotPasswordView({required this.repository})
    : super(ForgotPasswordState(isLoading: false));

  Future<bool> forgotPassword({required String email}) async {
    state = state.copyWith(isLoading: true, errorMessage: null, email: email);
    try {
      final success = await repository.forgotPassword(email: email);
      state = state.copyWith(isLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> verifyOtp({required String otp}) async {
    final email = state.email;
    if (email == null || email.isEmpty) return false;

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await repository.verifyResetOtp(email: email, otp: otp);
      state = state.copyWith(isLoading: false, isSuccess: success, resetToken: otp);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> resetPassword({
    required String password,
    required String passwordConfirmation,
  }) async {
    final email = state.email;
    final token = state.resetToken;
    if (email == null || email.isEmpty) return false;
    if (token == null || token.isEmpty) return false;

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await repository.resetPassword(
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        token: token,
      );
      state = state.copyWith(isLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}

class ForgotPasswordState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? email;
  final String? resetToken;

  const ForgotPasswordState({
    required this.isLoading,
    this.isSuccess = false,
    this.errorMessage,
    this.email,
    this.resetToken,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? email,
    String? resetToken,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      email: email ?? this.email,
      resetToken: resetToken ?? this.resetToken,
    );
  }
}
