import 'dart:convert';

/// Represents a single logged HTTP network transaction
class NetworkLogEntry {
  final String id;
  final DateTime timestamp;
  final String method;
  final String url;
  int? statusCode;
  int durationMs;
  final Map<String, dynamic> requestHeaders;
  final dynamic requestBody;
  dynamic responseBody;
  String? errorMessage;

  NetworkLogEntry({
    required this.id,
    required this.timestamp,
    required this.method,
    required this.url,
    this.statusCode,
    this.durationMs = 0,
    required this.requestHeaders,
    this.requestBody,
    this.responseBody,
    this.errorMessage,
  });

  bool get isSuccess =>
      statusCode != null && statusCode! >= 200 && statusCode! < 300;

  String get formattedRequestBody {
    if (requestBody == null) return 'Empty';
    try {
      final sanitized = _sanitizeData(requestBody);
      return const JsonEncoder.withIndent('  ').convert(sanitized);
    } catch (_) {
      return requestBody.toString();
    }
  }

  String get formattedResponseBody {
    if (responseBody == null) return errorMessage ?? 'No Content';
    try {
      return const JsonEncoder.withIndent('  ').convert(responseBody);
    } catch (_) {
      return responseBody.toString();
    }
  }

  String get curlCommand {
    final buffer = StringBuffer('curl -X $method "$url"');
    requestHeaders.forEach((key, value) {
      if (key.toLowerCase() != 'content-length') {
        buffer.write(' -H "$key: $value"');
      }
    });

    if (requestBody != null) {
      try {
        final bodyString = requestBody is String
            ? requestBody as String
            : jsonEncode(_sanitizeData(requestBody));
        buffer.write(" -d '$bodyString'");
      } catch (_) {
        buffer.write(" -d '$requestBody'");
      }
    }
    return buffer.toString();
  }

  dynamic _sanitizeData(dynamic data) {
    if (data is Map) {
      final sanitizedMap = <String, dynamic>{};
      data.forEach((key, value) {
        final keyLower = key.toString().toLowerCase();
        if (keyLower.contains('password') || keyLower.contains('secret')) {
          sanitizedMap[key.toString()] = '••••••';
        } else {
          sanitizedMap[key.toString()] = _sanitizeData(value);
        }
      });
      return sanitizedMap;
    }
    if (data is List) {
      return data.map(_sanitizeData).toList();
    }
    return data;
  }
}
