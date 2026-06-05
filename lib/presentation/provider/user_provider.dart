import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_clients.dart';
import '../../data/models/user_model.dart';
import '../../data/repositories/auth_repository.dart';
import '../../data/sources/remote/auth_api_service.dart';

class UserState {
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const UserState({this.user, this.isLoading = false, this.error});

  UserState copyWith({UserModel? user, bool? isLoading, String? error}) =>
      UserState(
        user: user ?? this.user,
        isLoading: isLoading ?? this.isLoading,
        error: error,
      );
}

class UserNotifier extends Notifier<UserState> {
  @override
  UserState build() => const UserState();

  Future<void> loadUser() async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = AuthRepository(
        remoteSource: AuthApiService(apiClient: ApiClient()),
      );
      final user = await repository.loadUser();
      state = UserState(user: user, isLoading: false);
    } catch (e) {
      state = UserState(isLoading: false, error: e.toString());
    }
  }
}

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);
