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
    : super(SignUpState(isLoading: false));

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String dob,
  }) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    try {
      final success = await repository.register(
        name: name,
        email: email,
        password: password,
        phone: phone,
        dob: dob,
      );
      state = state.copyWith(isLoading: false, isSuccess: success);
      return success;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final userCredential = await FirebaseService.signInWithGoogle();
      if (userCredential == null) {
        state = state.copyWith(isLoading: false);
        return false;
      }

      state = state.copyWith(isLoading: false, isSuccess: true);
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString().replaceFirst('Exception: ', ''),
      );
      return false;
    }
  }
}

class SignUpState {
  final bool isLoading;
  final bool isSuccess;
  final String? errorMessage;

  SignUpState({
    required this.isLoading,
    this.isSuccess = false,
    this.errorMessage,
  });

  SignUpState copyWith({
    bool? isLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSuccess ?? this.isSuccess,
      errorMessage: errorMessage,
    );
  }
}
