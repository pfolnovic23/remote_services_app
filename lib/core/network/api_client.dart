import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:logger/logger.dart';
import 'dart:io' show Platform;

class ApiClient {
  // Use localhost for web/desktop, 10.0.2.2 for Android emulator
  static String get baseUrl {
    try {
      if (Platform.isAndroid) {
        return 'http://10.0.2.2:3000';
      }
      return 'http://localhost:3000';
    } catch (e) {
      // For web or other platforms
      return 'http://localhost:3000';
    }
  }

  late Dio dio;
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  final Logger logger = Logger();

  ApiClient() {
    dio = Dio(BaseOptions(
      baseUrl: baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
    ));

    // Add interceptors
    dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          // Add OAuth2 token to every request
          final token = await storage.read(key: 'access_token');
          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          logger.d('REQUEST[${options.method}] => PATH: ${options.path}');
          return handler.next(options);
        },
        onResponse: (response, handler) {
          logger
              .i('RESPONSE[${response.statusCode}] => DATA: ${response.data}');
          return handler.next(response);
        },
        onError: (DioException e, handler) async {
          logger.e('ERROR[${e.response?.statusCode}] => MESSAGE: ${e.message}');

          // Handle 401 - Token expired
          if (e.response?.statusCode == 401) {
            // Try to refresh token
            final refreshed = await _refreshToken();
            if (refreshed) {
              // Retry original request
              return handler.resolve(await _retry(e.requestOptions));
            }
          }
          return handler.next(e);
        },
      ),
    );
  }

  Future<bool> _refreshToken() async {
    try {
      final refreshToken = await storage.read(key: 'refresh_token');
      if (refreshToken == null) return false;

      // Simulate token refresh (replace with real API call)
      await Future.delayed(const Duration(seconds: 1));

      // Mock new tokens
      await storage.write(
          key: 'access_token',
          value: 'new_access_token_${DateTime.now().millisecondsSinceEpoch}');

      logger.i('Token refreshed successfully');
      return true;
    } catch (e) {
      logger.e('Token refresh failed: $e');
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final options = Options(
      method: requestOptions.method,
      headers: requestOptions.headers,
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: options,
    );
  }
}
