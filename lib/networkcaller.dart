import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';
class NetworkResponse {
  final bool isSuccess;
  final int statusCode;
  final dynamic responseData;
  final String errorMessage;

  NetworkResponse({
    required this.isSuccess,
    required this.statusCode,
    this.responseData,
    this.errorMessage = 'Something went wrong',
  });
}

class NetworkCaller {
  static final Logger _logger = Logger();

  static Future<NetworkResponse> getRequest(String url) async {
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    _logResponse(url, response.statusCode, response.headers, response.body);
    if (response.statusCode == 200) {
      return NetworkResponse(
        isSuccess: true,
        statusCode: response.statusCode,
        responseData: jsonDecode(response.body),
      );
    } else {
      return NetworkResponse(
        isSuccess: false,
        statusCode: response.statusCode,
      );
    }
  }

  static void _logRequest(String url, [Map<String, dynamic>? headers, Map<String, dynamic>? body]) {
    _logger.i('URL => $url\nHeaders => $headers\nBODY => $body');
  }

  static void _logResponse(String url, int statusCode, Map<String, String>? headers, String body) {
    _logger.i('URL => $url\nHeaders => $headers\nStatus code => $statusCode\nBODY => $body');
  }
}
