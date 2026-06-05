import '../models/user_model.dart';
import '../sources/remote/auth_api_service.dart';

class AuthRepository {
  final AuthApiService remoteSource;

  AuthRepository({required this.remoteSource});

  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String dob,
  }) {
    return remoteSource.register(
      name: name,
      email: email,
      password: password,
      phone: phone,
      dob: dob,
    );
  }

  Future<bool> login({required String email, required String password}) async {
    return await remoteSource.login(email: email, password: password);
  }

  Future<UserModel?> loadUser() async {
    return await remoteSource.loadUser();
  }

  Future<UserModel?> updateProfile({
    String? name,
    String? avatar,
    String? address,
    String? phoneNumber,
    bool? billRemainders,
    bool? notificationRemainder,
    String? gender,
    String? dateOfBirth,
  }) async {
    return await remoteSource.updateProfile(
      name: name,
      avatar: avatar,
      address: address,
      phoneNumber: phoneNumber,
      billRemainders: billRemainders,
      notificationRemainder: notificationRemainder,
      gender: gender,
      dateOfBirth: dateOfBirth,
    );
  }

  Future<bool> logout() async {
    return await remoteSource.logout();
  }

  Future<bool> forgotPassword({required String email}) async {
    return await remoteSource.forgotPassword(email: email);
  }

  Future<bool> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    return await remoteSource.verifyResetOtp(email: email, otp: otp);
  }

  Future<bool> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String token,
  }) async {
    return await remoteSource.resetPassword(
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      token: token,
    );
  }
}
