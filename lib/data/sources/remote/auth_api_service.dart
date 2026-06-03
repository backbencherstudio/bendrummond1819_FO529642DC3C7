import 'dart:developer';
import '../../../core/network/api_clients.dart';
import '../../../core/network/api_endpoints.dart';
import '../local/shared_preference/shared_preference.dart';

class AuthApiService {
  final ApiClient apiClient;
  AuthApiService({required this.apiClient});
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

  Future<bool> login({required String email, required String password}) async {
    try {
      final body = {"email": email, "password": password};
      final dynamic response = await apiClient.postRequest(
        body: body,
        endpoints: ApiEndpoints.login,
      );
      if (response['success'] == true) {
        await SharedPreferenceData.setToken(
          response['authorization']['access_token'],
        );
        final token = await SharedPreferenceData.getToken();
        log("$token");
        return true;
      } else {
        return false;
      }
    } catch (error) {
      rethrow;
    }
  }
}
