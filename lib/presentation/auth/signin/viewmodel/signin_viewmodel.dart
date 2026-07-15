import 'package:flutter_riverpod/legacy.dart';

import '../../../../core/network/api_clients.dart';
import '../../../../core/services/firebase_service.dart';
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
    : super(SignInState(isEmailLoading: false, isGoogleLoading: false));

  Future<bool> signIn({required String email, required String password}) async {
    state = state.copyWith(isEmailLoading: true, errorMessage: null);

    try {
      final success = await repository.login(email: email, password: password);

      state = state.copyWith(isEmailLoading: false, isSuccess: success);

      return success;
    } catch (e) {
      state = state.copyWith(isEmailLoading: false, errorMessage: e.toString().replaceFirst('Exception: ', ''));

      return false;
    }
  }

  Future<bool> googleSignIn() async {
    state = state.copyWith(isGoogleLoading: true, errorMessage: null);

    try {
      final userCredential = await FirebaseService.signInWithGoogle();
      if (userCredential == null) {
        state = state.copyWith(isGoogleLoading: false);
        return false;
      }

      final idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        state = state.copyWith(isGoogleLoading: false, errorMessage: "Failed to get ID token");
        return false;
      }

      final success = await repository.googleLogin(idToken: idToken);
      state = state.copyWith(isGoogleLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(isGoogleLoading: false, errorMessage: e.toString().replaceFirst('Exception: ', ''));
      return false;
    }
  }
}

class SignInState {
  final bool isEmailLoading;
  final bool isGoogleLoading;
  final bool isSuccess;
  final String? errorMessage;

  const SignInState({
    required this.isEmailLoading,
    required this.isGoogleLoading,
    this.isSuccess = false,
    this.errorMessage,
  });

  SignInState copyWith({
    bool? isEmailLoading,
    bool? isGoogleLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignInState(
      isEmailLoading: isEmailLoading ?? this.isEmailLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
