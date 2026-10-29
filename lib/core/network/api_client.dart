import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../constants/app_strings.dart';
import '../constants/app_values.dart';
import 'pretty_dio_logger.dart';
import 'token_storage.dart';

class ApiException implements Exception {
  final String message;
  final int? statusCode;

  ApiException(this.message, [this.statusCode]);

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}

class ApiClient {
  static const String _envApiBaseUrl = String.fromEnvironment('API_BASE_URL');

  final Dio dio;
  final TokenStorage tokenStorage;

  ApiClient({required this.tokenStorage, Dio? customDio})
      : dio = customDio ??
            Dio(
              BaseOptions(
                baseUrl: determineBaseUrl(),
                connectTimeout: AppValues.apiTimeout,
                receiveTimeout: AppValues.apiTimeout,
                headers: {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json',
                },
              ),
            ) {
    dio.interceptors.addAll([
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final token = await tokenStorage.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
        onError: (DioException e, handler) {
          String errorMessage = AppStrings.networkError;
          if (e.response != null && e.response?.data != null) {
            final data = e.response?.data;
            if (data is Map && data.containsKey('detail')) {
              errorMessage = data['detail'].toString();
            }
          }
          return handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              response: e.response,
              type: e.type,
              error: ApiException(errorMessage, e.response?.statusCode),
            ),
          );
        },
      ),
      PrettyDioLogger(),
    ]);
  }

  static String determineBaseUrl({String? envOverride}) {
    final configured = (envOverride ?? _envApiBaseUrl).trim();
    if (configured.isNotEmpty) {
      return configured.replaceFirst(RegExp(r'/+$'), '');
    }
    if (kIsWeb) {
      return 'http://127.0.0.1:8000';
    }
    if (Platform.isAndroid) {
      return 'http://10.0.2.2:8000';
    }
    return 'http://127.0.0.1:8000';
  }
}

final apiClientProvider = Provider<ApiClient>((ref) {
  final tokenStorage = ref.watch(tokenStorageProvider);
  return ApiClient(tokenStorage: tokenStorage);
});
