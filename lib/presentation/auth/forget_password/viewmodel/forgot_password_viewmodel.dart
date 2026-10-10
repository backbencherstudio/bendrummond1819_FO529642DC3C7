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

  Future<String?> forgotPassword({required String phone}) async {
    state = state.copyWith(isLoading: true, errorMessage: null, phone: phone);
    try {
      final userId = await repository.forgotPassword(phone: phone);
      final success = userId != null;
      state = state.copyWith(isLoading: false, isSuccess: success, userId: userId);
      return userId;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString().replaceAll('Exception: ', ''));
      return null;
    }
  }

  Future<bool> verifyOtp({required String userId, required String otp}) async {
    if (userId.isEmpty) return false;

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final resetToken = await repository.verifyResetOtp(userId: userId, code: otp);
      final success = resetToken != null;
      state = state.copyWith(isLoading: false, isSuccess: success, resetToken: resetToken);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }

  Future<bool> resetPassword({
    required String password,
  }) async {
    final token = state.resetToken;
    if (token == null || token.isEmpty) return false;

    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await repository.resetPassword(
        password: password,
        resetToken: token,
      );
      state = state.copyWith(isLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString().replaceAll('Exception: ', ''));
      return false;
    }
  }
}

class ForgotPasswordState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;
  final String? phone;
  final String? resetToken;
  final String? userId;

  const ForgotPasswordState({
    required this.isLoading,
    this.isSuccess = false,
    this.errorMessage,
    this.phone,
    this.resetToken,
    this.userId,
  });

  ForgotPasswordState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
    String? phone,
    String? resetToken,
    String? userId,
  }) {
    return ForgotPasswordState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
      phone: phone ?? this.phone,
      resetToken: resetToken ?? this.resetToken,
      userId: userId ?? this.userId,
    );
  }
}
