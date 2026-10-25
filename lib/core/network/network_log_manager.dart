import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'network_log_entry.dart';

/// Central in-memory store for network logs in debug mode
class NetworkLogManager {
  NetworkLogManager._();
  static final NetworkLogManager instance = NetworkLogManager._();

  static const int _maxLogs = 50;
  final ValueNotifier<List<NetworkLogEntry>> logsNotifier =
      ValueNotifier<List<NetworkLogEntry>>([]);

  void addRequest(NetworkLogEntry entry) {
    final current = List<NetworkLogEntry>.from(logsNotifier.value);
    current.insert(0, entry);
    if (current.length > _maxLogs) {
      current.removeLast();
    }
    logsNotifier.value = current;
  }

  void updateEntry(
    String id, {
    int? statusCode,
    int? durationMs,
    dynamic responseBody,
    String? errorMessage,
  }) {
    final current = List<NetworkLogEntry>.from(logsNotifier.value);
    final index = current.indexWhere((element) => element.id == id);
    if (index != -1) {
      final item = current[index];
      if (statusCode != null) item.statusCode = statusCode;
      if (durationMs != null) item.durationMs = durationMs;
      if (responseBody != null) item.responseBody = responseBody;
      if (errorMessage != null) item.errorMessage = errorMessage;
      logsNotifier.value = current;
    }
  }

  void clear() {
    logsNotifier.value = [];
  }

  Future<void> copyToClipboard(String text) async {
    await Clipboard.setData(ClipboardData(text: text));
  }
}
