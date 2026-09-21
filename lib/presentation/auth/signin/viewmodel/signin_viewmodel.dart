import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/network/api_clients.dart';
import '../../../../core/resource/utils.dart';
import '../../../../core/services/firebase_service.dart';
import '../../../../data/repositories/auth_repository.dart';
import '../../../../data/sources/remote/auth_api_service.dart';

//********** Provider ************
final signInViewModelProvider =
    AsyncNotifierProvider<SignInModelview, SignInState>(SignInModelview.new);

//*********** Notifier*************
class SignInModelview extends AsyncNotifier<SignInState> {
  late final AuthRepository repository;

  @override
  Future<SignInState> build() async {
    repository = AuthRepository(
      remoteSource: AuthApiService(apiClient: ApiClient()),
    );
    return SignInState(
      isEmailLoading: false,
      isGoogleLoading: false,
      isAppleLoading: false,
    );
  }

  Future<bool> signIn({required String email, required String password}) async {
    final current =
        state.value ??
        const SignInState(
          isEmailLoading: false,
          isGoogleLoading: false,
          isAppleLoading: false,
        );
    state = AsyncData(
      current.copyWith(isEmailLoading: true, errorMessage: null),
    );
    try {
      final success = await repository.login(email: email, password: password);
      state = AsyncData(
        (state.value ?? current).copyWith(
          isEmailLoading: false,
          isSuccess: success,
        ),
      );
      return success;
    } catch (e) {
      state = AsyncData(
        (state.value ?? current).copyWith(
          isEmailLoading: false,
          errorMessage: Utils.friendlyErrorMessage(e),
        ),
      );
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    final current =
        state.value ??
        const SignInState(
          isEmailLoading: false,
          isGoogleLoading: false,
          isAppleLoading: false,
        );
    state = AsyncData(
      current.copyWith(isGoogleLoading: true, errorMessage: null),
    );
    try {
      final userCredential = await FirebaseServices.signInWithGoogle();

      if (userCredential == null) {
        state = AsyncData(
          (state.value ?? current).copyWith(isGoogleLoading: false),
        );
        return false;
      }
      final idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        state = AsyncData(
          (state.value ?? current).copyWith(
            isGoogleLoading: false,
            errorMessage: "Failed to get ID token",
          ),
        );
        return false;
      }
      final success = await repository.googleLogin(idToken: idToken);
      state = AsyncData(
        (state.value ?? current).copyWith(
          isGoogleLoading: false,
          isSuccess: success,
        ),
      );
      return success;
    } catch (e) {
      state = AsyncData(
        (state.value ?? current).copyWith(
          isGoogleLoading: false,
          errorMessage: Utils.friendlyErrorMessage(e),
        ),
      );
      return false;
    }
  }

  Future<bool> appleSignIn() async {
    final current =
        state.value ??
        const SignInState(
          isEmailLoading: false,
          isGoogleLoading: false,
          isAppleLoading: false,
        );
    state = AsyncData(
      current.copyWith(isAppleLoading: true, errorMessage: null),
    );
    try {
      final userCredential = await FirebaseServices.signInWithApple();

      final idToken = await userCredential.user?.getIdToken();

      if (idToken == null) {
        state = AsyncData(
          (state.value ?? current).copyWith(
            isAppleLoading: false,
            errorMessage: "Failed to get ID token",
          ),
        );
        return false;
      }
      final success = await repository.appleLogin(idToken: idToken);
      state = AsyncData(
        (state.value ?? current).copyWith(
          isAppleLoading: false,
          isSuccess: success,
        ),
      );
      return success;
    } catch (e) {
      state = AsyncData(
        (state.value ?? current).copyWith(
          isAppleLoading: false,
          errorMessage: Utils.friendlyErrorMessage(e),
        ),
      );
      return false;
    }
  }
}

//************ State ************
class SignInState {
  final bool isEmailLoading;
  final bool isGoogleLoading;
  final bool isAppleLoading;
  final bool isSuccess;
  final String? errorMessage;

  const SignInState({
    required this.isEmailLoading,
    required this.isGoogleLoading,
    required this.isAppleLoading,
    this.isSuccess = false,
    this.errorMessage,
  });

  SignInState copyWith({
    bool? isEmailLoading,
    bool? isGoogleLoading,
    bool? isAppleLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignInState(
      isEmailLoading: isEmailLoading ?? this.isEmailLoading,
      isGoogleLoading: isGoogleLoading ?? this.isGoogleLoading,
      isAppleLoading: isAppleLoading ?? this.isAppleLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
