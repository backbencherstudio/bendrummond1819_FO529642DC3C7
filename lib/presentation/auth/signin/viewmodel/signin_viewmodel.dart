import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/api_clients.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/sources/remote/auth_api_service.dart';

final signInViewModelProvider =
    StateNotifierProvider<SignInModelview, SignInState>(
      (ref) => SignInModelview(
        repository: AuthRepository(
          remoteSource: AuthApiService(apiClient: ApiClient()),
        ),
      ),
    );

class SignInModelview extends StateNotifier<SignInState> {
  final AuthRepository repository;

  SignInModelview({required this.repository})
    : super(SignInState(isLoading: false));

  Future<bool> signIn({required String email, required String password}) async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final success = await repository.login(email: email, password: password);

      state = state.copyWith(isLoading: false, isSuccess: success);

      return success;
    } catch (e) {
      state = state.copyWith(isLoading: false, errorMessage: e.toString());

      return false;
    }
  }
}

class SignInState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  const SignInState({
    required this.isLoading,
    this.isSuccess = false,
    this.errorMessage,
  });

  SignInState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignInState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
