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
    return await repository.login(email: email, password: password);
  }

  void isLoading() {
    state = state.copyWith(isLoading: !state.isLoading);
  }
}

class SignInState {
  final bool isLoading;
  SignInState({required this.isLoading});
  SignInState copyWith({bool? isLoading}) {
    return SignInState(isLoading: isLoading ?? this.isLoading);
  }
}
