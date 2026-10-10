import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import '../../../core/network/api_clients.dart';
import '../../../core/network/api_endpoints.dart';
import '../../models/user_model.dart';
import '../local/shared_preference/shared_preference.dart';

class AuthApiService {
  final ApiClient apiClient;
  AuthApiService({required this.apiClient});
  //register
  Future<String?> register({
    required String name,
    String? email,
    required String countryCode,
    required String password,
    required String phone,
    required String dob,
  }) async {
    try {
      final body = <String, dynamic>{
        "name": name,
        if (email != null && email.trim().isNotEmpty) "email": email.trim(),
        "countryCode": countryCode,
        "phone": phone,
        "birthDate": dob.replaceAll('/', '-'),
        "password": password,
      };
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.register,
        body: body,
      );

      if (response == null) return null;

      if (response is Map<String, dynamic>) {
        if (response['success'] == false ||
            response['error'] != null ||
            (response['statusCode'] != null && response['statusCode'] >= 400)) {
          var msg = response['message'] ?? response['error'] ?? 'Registration failed';
          if (msg is Map) {
            msg = msg['message'] ?? msg['error'] ?? msg.toString();
          }
          if (msg is List && msg.isNotEmpty) {
            msg = msg.join('\n');
          }
          throw Exception(msg.toString());
        }

        try {
          final token = response['authorization']?['access_token'];
          final refreshToken = response['authorization']?['refresh_token'];
          if (token != null) {
            await SharedPreferenceData.setToken(token);
            if (refreshToken != null) {
              await SharedPreferenceData.setRefreshToken(refreshToken);
            }
            await ApiClient.headerSet();
          }
        } catch (_) {
          log("Failed to save token from register response");
        }
      }

      final data = response['data'];
      if (data != null && data['userId'] != null) {
        return data['userId'].toString();
      }

      return "success";
    } catch (error) {
      log("Register error: ${error.toString()}");
      if (error is DioException &&
          error.response?.data is Map<String, dynamic>) {
        final data = error.response?.data as Map<String, dynamic>;
        var msg = data['message'] ?? data['error'] ?? 'Registration failed';
        if (msg is Map) {
          msg = msg['message'] ?? msg['error'] ?? msg.toString();
        }
        if (msg is List && msg.isNotEmpty) {
          msg = msg.join('\n');
        }
        throw Exception(msg.toString());
      }
      rethrow;
    }
  }

  //login
  Future<bool> login({required String phone, required String password}) async {
    try {
      final body = {"phone": phone, "password": password};
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.login,
      );

      if (response == null) return false;

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          throw Exception(
            response['message'] ?? response['error'] ?? 'Login failed',
          );
        }

        try {
          final token = response['authorization']?['access_token'];
          final refreshToken = response['authorization']?['refresh_token'];
          if (token != null) {
            await SharedPreferenceData.setToken(token);
            if (refreshToken != null) {
              await SharedPreferenceData.setRefreshToken(refreshToken);
            }
            await ApiClient.headerSet();
          }
        } catch (_) {
          log("Failed to save token");
        }
      }

      return true;
    } catch (error) {
      if (error is DioException &&
          error.response?.data is Map<String, dynamic>) {
        final msg = (error.response?.data as Map)['message'] ?? 'Login failed';
        throw Exception(msg);
      }
      rethrow;
    }
  }

  // google login
  Future<bool> googleLogin({required String idToken}) async {
    try {
      final body = {
        "idToken": idToken,
        "fcmToken": "",
        "platform": _devicePlatform(),
      };
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.googleLogin,
      );

      if (response == null) return false;

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          throw Exception(
            response['message'] ?? response['error'] ?? 'Google login failed',
          );
        }

        try {
          final token = response['authorization']?['access_token'];
          final refreshToken = response['authorization']?['refresh_token'];
          if (token != null) {
            await SharedPreferenceData.setToken(token);
            if (refreshToken != null) {
              await SharedPreferenceData.setRefreshToken(refreshToken);
            }
            await ApiClient.headerSet();
          }
        } catch (_) {
          log("Failed to save token from google login");
        }
      }

      return true;
    } catch (error) {
      if (error is DioException &&
          error.response?.data is Map<String, dynamic>) {
        final msg =
            (error.response?.data as Map)['message'] ?? 'Google login failed';
        throw Exception(msg);
      }
      rethrow;
    }
  }

  // apple login
  Future<bool> appleLogin({required String idToken}) async {
    try {
      final body = {
        "idToken": idToken,
        "fcmToken": "",
        "platform": _devicePlatform(),
      };
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.appleLogin,
      );

      if (response == null) return false;

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          throw Exception(
            response['message'] ?? response['error'] ?? 'Apple login failed',
          );
        }

        try {
          final token = response['authorization']?['access_token'];
          final refreshToken = response['authorization']?['refresh_token'];
          if (token != null) {
            await SharedPreferenceData.setToken(token);
            if (refreshToken != null) {
              await SharedPreferenceData.setRefreshToken(refreshToken);
            }
            await ApiClient.headerSet();
          }
        } catch (_) {
          log("Failed to save token from apple login");
        }
      }

      return true;
    } catch (error) {
      if (error is DioException &&
          error.response?.data is Map<String, dynamic>) {
        final msg =
            (error.response?.data as Map)['message'] ?? 'Apple login failed';
        throw Exception(msg);
      }
      rethrow;
    }
  }

  //load user
  Future<UserModel?> loadUser() async {
    try {
      final dynamic response = await apiClient.getRequest(
        endpoints: ApiEndpoints.loadUser,
      );

      if (response == null) return null;

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return null;
        }
        if (response['data'] != null) {
          return UserModel.fromJson(response['data'] as Map<String, dynamic>);
        }
      }

      return null;
    } catch (e) {
      log("Load user error: ${e.toString()}");
      rethrow;
    }
  }

  //forgotpassord
  Future<String?> forgotPassword({required String phone}) async {
    try {
      final body = {"phone": phone};
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.forgetPassword,
        body: body,
      );
      if (response == null) return null;

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return null;
        }
        return response['data']?['userId'] ?? response['userId']?.toString();
      }
      return null;
    } catch (error) {
      if (error is DioException &&
          error.response?.data is Map<String, dynamic>) {
        final data = error.response?.data as Map<String, dynamic>;
        var msg = data['message'] ?? data['error'] ?? 'Forgot password failed';
        if (msg is Map) {
          msg = msg['message'] ?? msg['error'] ?? msg.toString();
        }
        if (msg is List && msg.isNotEmpty) {
          msg = msg.join('\n');
        }
        throw Exception(msg.toString());
      }
      rethrow;
    }
  }

  //verify reset otp
  Future<String?> verifyResetOtp({
    required String userId,
    required String code,
  }) async {
    try {
      final body = {"userId": userId, "code": code};
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.verifyResetOtp,
        body: body,
      );
      if (response == null) return null;

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return null;
        }
        return response['data']?['resetToken']?.toString();
      }
      return null;
    } catch (error) {
      if (error is DioException &&
          error.response?.data is Map<String, dynamic>) {
        final data = error.response?.data as Map<String, dynamic>;
        var msg = data['message'] ?? data['error'] ?? 'OTP verification failed';
        if (msg is Map) {
          msg = msg['message'] ?? msg['error'] ?? msg.toString();
        }
        if (msg is List && msg.isNotEmpty) {
          msg = msg.join('\n');
        }
        throw Exception(msg.toString());
      }
      rethrow;
    }
  }

  //update profile
  Future<UserModel?> updateProfile({
    String? name,
    String? avatar,
    String? address,
    String? phoneNumber,
    bool? billRemainders,
    bool? notificationRemainder,
    bool? emailUpdates,
    String? gender,
    String? dateOfBirth,
  }) async {
    try {
      final Map<String, dynamic> data = {};
      if (name != null) data['name'] = name;
      if (address != null) data['address'] = address;
      if (phoneNumber != null) data['phone_number'] = phoneNumber;
      if (billRemainders != null) {
        data['bill_remainders'] = billRemainders.toString();
      }
      if (notificationRemainder != null) {
        data['notification_remainder'] = notificationRemainder.toString();
      }
      if (emailUpdates != null) {
        data['email_updates'] = emailUpdates.toString();
      }
      if (gender != null) data['gender'] = gender;
      if (dateOfBirth != null) data['date_of_birth'] = dateOfBirth;
      
      if (avatar != null && avatar.isNotEmpty) {
        data['image'] = await MultipartFile.fromFile(avatar);
      }

      final formData = FormData.fromMap(data);

      final dynamic response = await ApiClient.patchRequest(
        endpoints: ApiEndpoints.updateProfile,
        formData: formData,
      );

      if (response == null) return null;

      log("Update profile response: $response");

      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          throw Exception(
            response['message'] ?? response['error'] ?? 'Update failed',
          );
        }
      }

      return await loadUser();
    } catch (error) {
      if (error is DioException &&
          error.response?.data is Map<String, dynamic>) {
        final data = error.response?.data as Map<String, dynamic>;
        var msg = data['message'] ?? data['error'] ?? 'Update failed';
        if (msg is Map) {
          msg = msg['message'] ?? msg['error'] ?? msg.toString();
        }
        if (msg is List && msg.isNotEmpty) {
          msg = msg.join('\n');
        }
        throw Exception(msg.toString());
      }
      rethrow;
    }
  }

  //logout
  Future<bool> logout() async {
    try {
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.logout,
      );

      log("Logout response: $response");

      await SharedPreferenceData.removeToken();
      await SharedPreferenceData.removeRole();

      return true;
    } catch (e) {
      log("Logout error: ${e.toString()}");

      await SharedPreferenceData.removeToken();
      await SharedPreferenceData.removeRole();

      return true;
    }
  }

  //delete account
  Future<bool> deleteAccount() async {
    try {
      final dynamic response = await ApiClient.deleteRequest(
        endpoints: ApiEndpoints.deleteAccount,
      );

      log("Delete account response: $response");

      await SharedPreferenceData.removeToken();
      await SharedPreferenceData.removeRole();

      return true;
    } catch (e) {
      log("Delete account error: ${e.toString()}");

      await SharedPreferenceData.removeToken();
      await SharedPreferenceData.removeRole();

      return true;
    }
  }

  //verify email (signup otp)
  Future<bool> verifyEmail({required String email, required String otp}) async {
    try {
      final body = {"email": email, "token": otp};
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.verifyMail,
        body: body,
      );
      if (response == null) return false;
      log("Verify email response: $response");
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

  //verify phone
  Future<bool> verifyPhone({required String userId, required String code}) async {
    try {
      final body = {"userId": userId, "code": code};
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.verifyPhone,
        body: body,
      );
      if (response == null) return false;
      log("Verify phone response: $response");
      if (response is Map<String, dynamic>) {
        if (response['success'] == false || response['error'] != null) {
          return false;
        }
        
        try {
          final token = response['accessToken'] ?? 
                        response['authorization']?['access_token'] ?? 
                        response['data']?['accessToken'];
          final refreshToken = response['refreshToken'] ?? 
                               response['authorization']?['refresh_token'] ?? 
                               response['data']?['refreshToken'];
          if (token != null) {
            await SharedPreferenceData.setToken(token);
            if (refreshToken != null) {
              await SharedPreferenceData.setRefreshToken(refreshToken);
            }
            await ApiClient.headerSet();
          }
        } catch (_) {
          log("Failed to save token from verify phone response");
        }
      }
      return true;
    } catch (error) {
      rethrow;
    }
  }

  //resend otp (signup)
  Future<bool> resendOtp({required String email}) async {
    try {
      final body = {"email": email};
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.resendOtp,
        body: body,
      );
      if (response == null) return false;
      log("Resend OTP response: $response");
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

  //resend phone otp
  Future<bool> resendPhoneOtp({required String userId}) async {
    try {
      final body = {"userId": userId};
      final dynamic response = await apiClient.postRequest(
        endpoints: ApiEndpoints.resendPhoneOtp,
        body: body,
      );
      if (response == null) return false;
      log("Resend Phone OTP response: $response");
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
    required String password,
    required String resetToken,
  }) async {
    try {
      final body = {
        "password": password,
        "resetToken": resetToken,
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
      if (error is DioException &&
          error.response?.data is Map<String, dynamic>) {
        final data = error.response?.data as Map<String, dynamic>;
        var msg = data['message'] ?? data['error'] ?? 'Reset password failed';
        if (msg is Map) {
          msg = msg['message'] ?? msg['error'] ?? msg.toString();
        }
        if (msg is List && msg.isNotEmpty) {
          msg = msg.join('\n');
        }
        throw Exception(msg.toString());
      }
      rethrow;
    }
  }

  String _devicePlatform() {
    if (kIsWeb) return 'web';
    switch (defaultTargetPlatform) {
      case TargetPlatform.iOS:
        return 'ios';
      case TargetPlatform.android:
        return 'android';
      case TargetPlatform.macOS:
        return 'macos';
      case TargetPlatform.windows:
        return 'windows';
      case TargetPlatform.linux:
        return 'linux';
      case TargetPlatform.fuchsia:
        return 'fuchsia';
    }
  }
}
