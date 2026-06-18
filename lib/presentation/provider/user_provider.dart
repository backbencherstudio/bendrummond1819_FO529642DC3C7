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

  Future<bool> updateProfile({
    String? name,
    String? avatar,
    String? address,
    String? phoneNumber,
    bool? billRemainders,
    bool? notificationRemainder,
    String? gender,
    String? dateOfBirth,
  }) async {
    state = state.copyWith(isLoading: true, error: null);
    try {
      final repository = AuthRepository(
        remoteSource: AuthApiService(apiClient: ApiClient()),
      );
      await repository.updateProfile(
        name: name,
        avatar: avatar,
        address: address,
        phoneNumber: phoneNumber,
        billRemainders: billRemainders,
        notificationRemainder: notificationRemainder,
        gender: gender,
        dateOfBirth: dateOfBirth,
      );
      await loadUser();
      return true;
    } catch (e) {
      state = UserState(isLoading: false, error: e.toString());
      return false;
    }
  }
}

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);
