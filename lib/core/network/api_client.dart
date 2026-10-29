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
          return handler.reject(
            DioException(
              requestOptions: e.requestOptions,
              response: e.response,
              type: e.type,
              error: mapError(e),
            ),
          );
        },
      ),
      PrettyDioLogger(),
    ]);
  }

  /// Converts any [DioException] into a user-facing [ApiException].
  static ApiException mapError(DioException e) {
    final status = e.response?.statusCode;
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.transformTimeout:
        return ApiException(AppStrings.networkTimeout, status);
      case DioExceptionType.connectionError:
        return ApiException(AppStrings.networkError, status);
      case DioExceptionType.badCertificate:
        return ApiException(AppStrings.badCertificate, status);
      case DioExceptionType.cancel:
        return ApiException(AppStrings.requestCancelled, status);
      case DioExceptionType.badResponse:
        final detail = _extractDetail(e.response?.data);
        if (detail != null) return ApiException(detail, status);
        return ApiException(AppStrings.unknownError, status);
      case DioExceptionType.unknown:
        return ApiException(
          e.error is SocketException
              ? AppStrings.networkError
              : AppStrings.unknownError,
          status,
        );
    }
  }

  static String? _extractDetail(dynamic data) {
    if (data is! Map || !data.containsKey('detail')) return null;
    final detail = data['detail'];
    if (detail is String && detail.trim().isNotEmpty) return detail;
    if (detail is List && detail.isNotEmpty) {
      final first = detail.first;
      if (first is Map && first['msg'] != null) return first['msg'].toString();
      return first.toString();
    }
    return null;
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
