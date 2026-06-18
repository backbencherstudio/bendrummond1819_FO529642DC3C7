import 'dart:developer';
import 'package:dio/dio.dart';
class ResposeHandle {

   static dynamic handleResponse(Response response) {
    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
       // log("Success: ${jsonDecode(response.data.toString())}");
      log("Success: ${response.data}");
        return response.data;
      } else {
        log("Error Response: ${response.statusCode} - ${response.data}");
        final message = response.data is Map
            ? (response.data['message'] ?? response.data['error'] ?? response.data.toString())
            : response.data.toString();
        throw Exception(message);
      }
    } catch (e) {
      throw Exception("Failed to parse response: $e");
    }
  }
}