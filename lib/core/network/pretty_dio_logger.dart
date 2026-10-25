import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'network_log_entry.dart';
import 'network_log_manager.dart';

/// Clean, high-performance Dio Logger with ASCII box formatting and cURL generation
class PrettyDioLogger extends Interceptor {
  PrettyDioLogger();

  static const String _logIdKey = '_kiddora_log_id';
  static const String _stopwatchKey = '_kiddora_stopwatch';

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final logId = DateTime.now().microsecondsSinceEpoch.toString();
    final stopwatch = Stopwatch()..start();
    options.extra[_logIdKey] = logId;
    options.extra[_stopwatchKey] = stopwatch;

    final entry = NetworkLogEntry(
      id: logId,
      timestamp: DateTime.now(),
      method: options.method.toUpperCase(),
      url: options.uri.toString(),
      requestHeaders: Map<String, dynamic>.from(options.headers),
      requestBody: options.data,
    );
    NetworkLogManager.instance.addRequest(entry);

    if (kDebugMode) {
      final buffer = StringBuffer();
      buffer.writeln('┌── [DIO-REQ] ${entry.method}: ${entry.url} ──────');
      buffer.writeln('│ [cURL]: ${entry.curlCommand}');
      if (options.data != null) {
        buffer.writeln('│ [Body]:');
        final lines = entry.formattedRequestBody.split('\n');
        for (final line in lines) {
          buffer.writeln('│   $line');
        }
      }
      buffer.write('└──────────────────────────────────────────────────');
      debugPrint(buffer.toString());
    }

    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    final logId = response.requestOptions.extra[_logIdKey] as String?;
    final stopwatch =
        response.requestOptions.extra[_stopwatchKey] as Stopwatch?;
    final durationMs = stopwatch?.elapsedMilliseconds ?? 0;

    if (logId != null) {
      NetworkLogManager.instance.updateEntry(
        logId,
        statusCode: response.statusCode,
        durationMs: durationMs,
        responseBody: response.data,
      );
    }

    if (kDebugMode) {
      final buffer = StringBuffer();
      final status = response.statusCode ?? 0;
      buffer.writeln(
        '┌── [DIO-RES] [$status] (${durationMs}ms): ${response.requestOptions.uri} ──',
      );
      if (response.data != null) {
        buffer.writeln('│ [Data]:');
        String prettyData;
        try {
          prettyData =
              const JsonEncoder.withIndent('  ').convert(response.data);
        } catch (_) {
          prettyData = response.data.toString();
        }
        final lines = prettyData.split('\n');
        for (final line in lines) {
          buffer.writeln('│   $line');
        }
      }
      buffer.write('└──────────────────────────────────────────────────');
      debugPrint(buffer.toString());
    }

    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    final logId = err.requestOptions.extra[_logIdKey] as String?;
    final stopwatch = err.requestOptions.extra[_stopwatchKey] as Stopwatch?;
    final durationMs = stopwatch?.elapsedMilliseconds ?? 0;
    final statusCode = err.response?.statusCode;
    final errorMessage = err.message ?? err.error?.toString() ?? 'Unknown Error';

    if (logId != null) {
      NetworkLogManager.instance.updateEntry(
        logId,
        statusCode: statusCode,
        durationMs: durationMs,
        responseBody: err.response?.data,
        errorMessage: errorMessage,
      );
    }

    if (kDebugMode) {
      final buffer = StringBuffer();
      buffer.writeln(
        '┌── [DIO-ERR] [${statusCode ?? "ERR"}] (${durationMs}ms): ${err.requestOptions.uri} ──',
      );
      buffer.writeln('│ [Message]: $errorMessage');
      if (err.response?.data != null) {
        buffer.writeln('│ [Response Data]:');
        String prettyData;
        try {
          prettyData =
              const JsonEncoder.withIndent('  ').convert(err.response?.data);
        } catch (_) {
          prettyData = err.response?.data.toString() ?? '';
        }
        final lines = prettyData.split('\n');
        for (final line in lines) {
          buffer.writeln('│   $line');
        }
      }
      buffer.write('└──────────────────────────────────────────────────');
      debugPrint(buffer.toString());
    }

    return handler.next(err);
  }
}
