import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/core/network/api_client.dart';
import 'package:kiddora/core/network/token_storage.dart';

void main() {
  group('ApiClient Remote Server Base URL Resolution', () {
    test('falls back to localhost on desktop/iOS/macOS when API_BASE_URL is empty', () {
      expect(ApiClient.determineBaseUrl(envOverride: ''), 'http://127.0.0.1:8000');
      expect(ApiClient.determineBaseUrl(envOverride: '   '), 'http://127.0.0.1:8000');
    });

    test('uses LAN or Tailscale API_BASE_URL override when provided', () {
      expect(
        ApiClient.determineBaseUrl(envOverride: 'http://192.168.3.119:8000'),
        'http://192.168.3.119:8000',
      );
      expect(
        ApiClient.determineBaseUrl(envOverride: 'http://100.88.12.34:8000'),
        'http://100.88.12.34:8000',
      );
    });

    test('strips trailing slashes from API_BASE_URL override', () {
      expect(
        ApiClient.determineBaseUrl(envOverride: 'http://desktop-ghcs3nb:8000/'),
        'http://desktop-ghcs3nb:8000',
      );
      expect(
        ApiClient.determineBaseUrl(envOverride: ' http://192.168.3.119:8000/// '),
        'http://192.168.3.119:8000',
      );
    });

    test('initializes Dio with AppValues.apiTimeout', () {
      final client = ApiClient(tokenStorage: TokenStorage(null));
      expect(client.dio.options.connectTimeout, AppValues.apiTimeout);
      expect(client.dio.options.receiveTimeout, AppValues.apiTimeout);
    });
  });
}
