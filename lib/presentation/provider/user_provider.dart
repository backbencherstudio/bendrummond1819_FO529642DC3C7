import 'package:dio/dio.dart';
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

  Future<String?> updateProfile({
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
      final updatedUser = await repository.updateProfile(
        name: name,
        avatar: avatar,
        address: address,
        phoneNumber: phoneNumber,
        billRemainders: billRemainders,
        notificationRemainder: notificationRemainder,
        gender: gender,
        dateOfBirth: dateOfBirth,
      );
      if (updatedUser != null) {
        state = UserState(user: updatedUser, isLoading: false);
        return null;
      } else {
        await loadUser();
        return null;
      }
    } catch (e) {
      final msg = _extractMessage(e);
      state = UserState(isLoading: false, error: msg);
      return _friendlyError(msg);
    }
  }

  String _extractMessage(Object e) {
    if (e is DioException && e.response?.data is Map<String, dynamic>) {
      return (e.response!.data as Map<String, dynamic>)['message']
              ?.toString() ??
          e.toString();
    }
    return e.toString().replaceFirst('Exception: ', '');
  }

  String _friendlyError(String serverMsg) {
    if (serverMsg.toLowerCase().contains('request entity too large')) {
      return 'The image is too large. Please choose a smaller one.';
    }
    return 'Something went wrong. Please try again.';
  }
}

final userProvider = NotifierProvider<UserNotifier, UserState>(
  UserNotifier.new,
);
