import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../data/sources/local/shared_preference/shared_preference.dart';
import 'api_endpoints.dart';
import 'error_handle.dart';
import 'response_handle.dart';

class ApiClient {
  static final Dio _dio = Dio(
    BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: Duration(seconds: 10),
      sendTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
    ),
  );

  static Future<Map<String, String>> _authHeaders() async {
    final token = await SharedPreferenceData.getToken();
    return {
      'Content-Type': 'application/json',
      if (token != null && token.isNotEmpty) 'Authorization': 'Bearer $token',
    };
  }

  static Future<void> headerSet() async {
    // kept for callers that await it, but no longer needed
    await _authHeaders();
  }

  /// GET request
 Future<dynamic> getRequest({
    required String endpoints,
  }) async {
    try {
      log("\n\n\n\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      final response = await _dio.get(
        '/$endpoints',
        options: Options(
          headers: await _authHeaders(),
        ),
      );
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
      } else {
        log('Non-Dio error: $e');
      }
    }
  }

  /// POST request
   Future<dynamic> postRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    FormData? formData,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.post(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: await _authHeaders(),
        ),
      );
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        rethrow;
      } else {
        log('Non-Dio error: $e');
        rethrow;
      }
    }
  }

  /// PUT request
  static Future<dynamic> putRequest({
    required String endpoints,
    required Map<String, dynamic> body,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.put(
        '/$endpoints',
        data: body,
        options: Options(
          headers: await _authHeaders(),
        ),
      );
      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
      } else {
        log('Non-Dio error: $e');
      }
    }
  }

  /// PATCH request
  static Future<dynamic> patchRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    FormData? formData,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.patch(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: await _authHeaders(),
        ),
      );

      debugPrint("\nPATCH Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
        rethrow;
      } else {
        log('Non-Dio error: $e');
        rethrow;
      }
    }
  }

  /// DELETE request
  static Future<dynamic> deleteRequest({
    required String endpoints,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}/$endpoints\n\n");
      final response = await _dio.delete(
        '/$endpoints',
        options: Options(
          headers: await _authHeaders(),
        ),
      );

      debugPrint("delete Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResposeHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        ErrorHandle.handleDioError(e);
      } else {
        log('Non-Dio error: $e');
      }
    }
  }
}
