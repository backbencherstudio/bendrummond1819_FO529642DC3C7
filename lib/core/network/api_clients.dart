import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../storage/shared_preference.dart';
import '../network/api_endpoints.dart';
import '../network/error_handle.dart';
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
  static Map<String, String>? headers;

  static Future<void> headerSet() async {
    final token = await SharedPreferenceData.getToken();
    log(token ?? 'token');

    headers = {
      'Content-Type': 'application/json',
      "Accept": "*/*",
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  /// GET request
  Future<dynamic> getRequest({
    required String endpoints,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      log("\nurl :${ApiEndpoints.baseUrl}/$endpoints \n\n\n\n");
      //log("POST PARAMS => ${body.toString()}");
      log("QUERY PARAMS => ${queryParameters.toString()}");
      final response = await _dio.get(
        queryParameters: queryParameters,
        '/$endpoints',
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      // log("\n\n\nGET Request Successful: ${response.data}\n\n\n");
      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {"success": false, "message": "Unexpected error: $e"};
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
      log("\n URL :${ApiEndpoints.baseUrl}$endpoints \n\n\n\n");
      log("\n body: $body");
      final response = await _dio.post(
        '/$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        if (e.type == DioExceptionType.badResponse &&
            e.response?.data != null) {
          return e.response!.data;
        }
        // Return the user-friendly error string
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {
          "success": false,
          "message": "An unexpected error occurred: $e",
        };
      }
    }
  }

  /// PUT request
  static Future<dynamic> putRequest({
    required String endpoints,
    required Map<String, dynamic> body,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}$endpoints\n\n");
      final response = await _dio.put(
        '/$endpoints',
        data: body,
        options: Options(
          headers: headers ?? {"Content-Type": "application/json"},
        ),
      );
      // debugPrint("\nPUT Request Successful: ${response.data}\n");
      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {"success": false, "message": "Unexpected error: $e"};
      }
    }
  }

  /// PATCH request
  Future<dynamic> patchRequest({
    required String endpoints,
    Map<String, dynamic>? body,
    FormData? formData,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}$endpoints\n\n");
      final response = await _dio.patch(
        '${ApiEndpoints.baseUrl}$endpoints',
        data: body ?? formData,
        options: Options(
          headers: headers ?? {"Content-Type": "multipart/form-data"},
        ),
      );

      debugPrint("\nPATCH Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {"success": false, "message": "Unexpected error: $e"};
      }
    }
  }

  /// Delete request
  Future<dynamic> deleteRequest({
    required String endpoints,
  }) async {
    try {
      log("\n\nurl :${ApiEndpoints.baseUrl}$endpoints\n\n");
      final response = await _dio.delete(
        '/$endpoints',
        options: Options(
          headers: headers ?? {"Content-Type": "multipart/form-data"},
        ),
      );

      debugPrint("delete Request Successful");
      debugPrint("Status: ${response.statusCode}");
      debugPrint("Data: ${response.data}");

      return ResponseHandle.handleResponse(response);
    } catch (e) {
      if (e is DioException) {
        return {"success": false, "message": ErrorHandle.handleDioError(e)};
      } else {
        return {"success": false, "message": "Unexpected error: $e"};
      }
    }
  }
}
