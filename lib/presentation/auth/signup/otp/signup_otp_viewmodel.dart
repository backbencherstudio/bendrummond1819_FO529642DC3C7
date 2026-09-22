import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/network/api_clients.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/sources/remote/auth_api_service.dart';

final signupOtpViewModelProvider =
    StateNotifierProvider<SignupOtpViewmodel, SignupOtpState>(
      (ref) => SignupOtpViewmodel(
        repository: AuthRepository(
          remoteSource: AuthApiService(apiClient: ApiClient()),
        ),
      ),
    );

class SignupOtpViewmodel extends StateNotifier<SignupOtpState> {
  final AuthRepository repository;

  SignupOtpViewmodel({required this.repository})
    : super(SignupOtpState(isLoading: false));

  Future<bool> verifyEmail({
    required String email,
    required String otp,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await repository.verifyEmail(email: email, otp: otp);
      state = state.copyWith(isLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }

  Future<bool> resendOtp({required String email}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await repository.resendOtp(email: email);
      state = state.copyWith(isLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
      return false;
    }
  }
}

class SignupOtpState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const SignupOtpState({
    required this.isLoading,
    this.isSuccess = false,
    this.errorMessage,
  });

  SignupOtpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignupOtpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
