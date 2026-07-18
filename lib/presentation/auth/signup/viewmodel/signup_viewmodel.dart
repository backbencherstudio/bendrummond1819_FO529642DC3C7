import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/network/api_clients.dart';
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
    : super(SignUpState(isEmailLoading: false, isGoogleLoading: false));

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
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
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
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

class SignUpState {
  final bool isEmailLoading;
  final bool isGoogleLoading;
  final bool isSuccess;
  final String? errorMessage;

  SignUpState({
    required this.isEmailLoading,
    required this.isGoogleLoading,
    this.isSuccess = false,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? isEmailLoading,
    bool? isGoogleLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignUpState(
      isEmailLoading: isEmailLoading ?? this.isEmailLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
