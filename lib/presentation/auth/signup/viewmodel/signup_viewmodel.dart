import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/network/api_clients.dart';
import '../../../../core/resource/utils.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/sources/remote/auth_api_service.dart';

final signUpViewModelProvider =
    StateNotifierProvider<SignUpModelview, SignUpState>(
      (ref) => SignUpModelview(
        repository: AuthRepository(
          remoteSource: AuthApiService(apiClient: ApiClient()),
        ),
      ),
    );

class SignUpModelview extends StateNotifier<SignUpState> {
  final AuthRepository repository;
  SignUpModelview({required this.repository})
    : super(
        SignUpState(
          isEmailLoading: false,
          isGoogleLoading: false,
          isAppleLoading: false,
        ),
      );

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String dob,
  }) async {
    state = state.copyWith(isEmailLoading: true, errorMessage: null);
    try {
      final success = await repository.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        dob: dob,
      );
      state = state.copyWith(isEmailLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(
        isEmailLoading: false,
        errorMessage: Utils.friendlyErrorMessage(e),
      );
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    state = state.copyWith(isGoogleLoading: true, errorMessage: null);

    try {
      final userCredential = await FirebaseServices.signInWithGoogle();
      if (userCredential == null) {
        state = state.copyWith(isGoogleLoading: false);
        return false;
      }

      final idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        state = state.copyWith(
          isGoogleLoading: false,
          errorMessage: "Failed to get ID token",
        );
        return false;
      }

      final success = await repository.googleLogin(idToken: idToken);
      state = state.copyWith(isGoogleLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(
        isGoogleLoading: false,
        errorMessage: Utils.friendlyErrorMessage(e),
      );
      return false;
    }
  }

  Future<bool> appleSignIn() async {
    state = state.copyWith(isAppleLoading: true, errorMessage: null);

    try {
      final userCredential = await FirebaseServices.signInWithApple();

      final idToken = await userCredential.user?.getIdToken();
      if (idToken == null) {
        state = state.copyWith(
          isAppleLoading: false,
          errorMessage: "Failed to get ID token",
        );
        return false;
      }

      final success = await repository.appleLogin(idToken: idToken);
      state = state.copyWith(isAppleLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(
        isAppleLoading: false,
        errorMessage: Utils.friendlyErrorMessage(e),
      );
      return false;
    }
  }
}

class SignUpState {
  final bool isEmailLoading;
  final bool isGoogleLoading;
  final bool isAppleLoading;
  final bool isSuccess;
  final String? errorMessage;

  SignUpState({
    required this.isEmailLoading,
    required this.isGoogleLoading,
    required this.isAppleLoading,
    this.isSuccess = false,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? isEmailLoading,
    bool? isGoogleLoading,
    bool? isAppleLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignUpState(
      isEmailLoading: isEmailLoading ?? this.isEmailLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isAppleLoading: isAppleLoading ?? this.isAppleLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
