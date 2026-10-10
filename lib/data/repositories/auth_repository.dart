import '../models/user_model.dart';
import '../sources/remote/auth_api_service.dart';

class AuthRepository {
  final AuthApiService remoteSource;

  AuthRepository({required this.remoteSource});

  Future<String?> register({
    required String name,
    String? email,
    required String countryCode,
    required String password,
    required String phone,
    required String dob,
  }) {
    return remoteSource.register(
      name: name,
      email: email,
      countryCode: countryCode,
      password: password,
      phone: phone,
      dob: dob,
    );
  }

  Future<bool> login({required String phone, required String password}) async {
    return await remoteSource.login(phone: phone, password: password);
  }

  Future<bool> googleLogin({required String idToken}) async {
    return await remoteSource.googleLogin(idToken: idToken);
  }

  Future<bool> appleLogin({required String idToken}) async {
    return await remoteSource.appleLogin(idToken: idToken);
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

  Future<bool> deleteAccount() async {
    return await remoteSource.deleteAccount();
  }

  Future<String?> forgotPassword({required String phone}) async {
    return await remoteSource.forgotPassword(phone: phone);
  }

  Future<String?> verifyResetOtp({
    required String userId,
    required String code,
  }) async {
    return await remoteSource.verifyResetOtp(userId: userId, code: code);
  }

  Future<bool> verifyEmail({required String email, required String otp}) async {
    return await remoteSource.verifyEmail(email: email, otp: otp);
  }

  Future<bool> verifyPhone({required String userId, required String code}) async {
    return await remoteSource.verifyPhone(userId: userId, code: code);
  }

  Future<bool> resendOtp({required String email}) async {
    return await remoteSource.resendOtp(email: email);
  }

  Future<bool> resendPhoneOtp({required String userId}) async {
    return await remoteSource.resendPhoneOtp(userId: userId);
  }

  Future<bool> resetPassword({
    required String password,
    required String resetToken,
  }) async {
    return await remoteSource.resetPassword(
      password: password,
      resetToken: resetToken,
    );
  }
}
