import 'package:flutter_test/flutter_test.dart';
import 'package:dio/dio.dart';
import 'package:kiddora/core/network/api_client.dart';
import 'package:kiddora/core/network/token_storage.dart';
import 'package:kiddora/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kiddora/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:kiddora/features/onboarding/data/datasources/onboarding_local_datasource.dart';

class MockAdapter implements HttpClientAdapter {
  final Map<String, dynamic> responseData;
  final int statusCode;

  MockAdapter({required this.responseData, this.statusCode = 200});

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    return ResponseBody.fromString(
      responseData.toString(),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('TokenStorage In-Memory & Fallback Tests', () {
    test('saveTokens and getAccessToken work in-memory', () async {
      final tokenStorage = TokenStorage(null);

      await tokenStorage.saveTokens(
        accessToken: 'access_123',
        refreshToken: 'refresh_456',
      );

      final access = await tokenStorage.getAccessToken();
      final refresh = await tokenStorage.getRefreshToken();
      final isGuest = await tokenStorage.isGuestMode();

      expect(access, equals('access_123'));
      expect(refresh, equals('refresh_456'));
      expect(isGuest, isFalse);

      await tokenStorage.clearTokens();
      expect(await tokenStorage.getAccessToken(), isNull);
    });

    test('guest mode toggle works in-memory', () async {
      final tokenStorage = TokenStorage(null);

      await tokenStorage.setGuestMode(true);
      expect(await tokenStorage.isGuestMode(), isTrue);

      await tokenStorage.setGuestMode(false);
      expect(await tokenStorage.isGuestMode(), isFalse);
    });
  });

  group('AuthRepositoryImpl Unit Tests', () {
    test('logout clears tokens and local datasource', () async {
      final tokenStorage = TokenStorage(null);
      await tokenStorage.saveTokens(accessToken: 'a', refreshToken: 'r');

      final localDataSource = const OnboardingLocalDataSource();
      final dio = Dio();
      final apiClient = ApiClient(tokenStorage: tokenStorage, customDio: dio);
      final remoteDataSource = AuthRemoteDataSource(apiClient);

      final repo = AuthRepositoryImpl(
        remoteDataSource: remoteDataSource,
        tokenStorage: tokenStorage,
        localDataSource: localDataSource,
      );

      await repo.logout();
      expect(await tokenStorage.getAccessToken(), isNull);
    });
  });
}
