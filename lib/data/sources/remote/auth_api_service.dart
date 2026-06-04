import 'dart:developer';
import '../../../core/network/api_clients.dart';
import '../../../core/network/api_endpoints.dart';
import '../local/shared_preference/shared_preference.dart';

class AuthApiService {
  final ApiClient apiClient;
  AuthApiService({required this.apiClient});
  //register
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    required String phone,
    required String dob,
  }) async {
    try {
      final body = {
        "name": name,
        "email": email,
        "password": password,
        "phone": phone,
        "birthDate": dob,
      };
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.register,
        body: body,
      );

      if (response == null) return false;

      log("Register response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }

      return true;
    } catch (e) {
      log("Register error: ${e.toString()}");
      rethrow;
    }
  }

  //login
  Future<bool> login({required String email, required String password}) async {
    try {
      final body = {"email": email, "password": password};
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.login,
      );

      if (response == null) return false;

      log("Login response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }

        try {
          final token = response['authorization']?['access_token'];
          if (token != null) {
            await SharedPreferenceData.setToken(token);
            await ApiClient.headerSet();
          }
        } catch (_) {
          log("Failed to save token");
        }
      }

      return true;
    } catch (error) {
      rethrow;
    }
  }

  //forgotpassord
  Future<bool> forgotPassword({required String email}) async {
    try {
      final body = {"email": email};
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.forgetPassword,
        body: body,
      );
      if (response == null) return false;
      log("Forgot Password response: $response");
      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }

  //verify reset otp
  Future<bool> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    try {
      final body = {"email": email, "token": otp};
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.verifyResetOtp,
        body: body,
      );
      if (response == null) return false;
      log("Verify Reset OTP response: $response");
      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }

  //reset password
  Future<bool> resetPassword({
    required String email,
    required String password,
    required String passwordConfirmation,
    required String token,
  }) async {
    try {
      final body = {
        "email": email,
        "password": password,
        "password_confirmation": passwordConfirmation,
        "token": token,
      };
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.resetPassword,
        body: body,
      );
      if (response == null) return false;
      log("Reset Password response: $response");
      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }
}
