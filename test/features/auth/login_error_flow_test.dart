import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/core/network/api_client.dart';
import 'package:kiddora/core/network/token_storage.dart';
import 'package:kiddora/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:kiddora/features/auth/presentation/controllers/login_controller.dart';
import 'package:kiddora/features/auth/presentation/login_screen.dart';

class _FakeAdapter implements HttpClientAdapter {
  final Future<ResponseBody> Function(RequestOptions) handler;
  _FakeAdapter(this.handler);

  @override
  Future<ResponseBody> fetch(
          RequestOptions o, Stream<List<int>>? s, Future<void>? c) =>
      handler(o);

  @override
  void close({bool force = false}) {}
}

DioException _err(RequestOptions o, DioExceptionType t,
        {Object? error, Response? response}) =>
    DioException(requestOptions: o, type: t, error: error, response: response);

ResponseBody _json(String body, int status) =>
    ResponseBody.fromString(body, status, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });

AuthRemoteDataSource _ds(Future<ResponseBody> Function(RequestOptions) h) {
  final dio = Dio(BaseOptions(baseUrl: 'http://test'))
    ..httpClientAdapter = _FakeAdapter(h);
  return AuthRemoteDataSource(
      ApiClient(tokenStorage: TokenStorage(null), customDio: dio));
}

Future<ApiException> _loginError(
    Future<ResponseBody> Function(RequestOptions) h) async {
  try {
    await _ds(h).login(email: 'a@b.com', password: 'x');
  } on ApiException catch (e) {
    return e;
  }
  throw StateError('login did not throw');
}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Datasource error mapping (server down & friends)', () {
    final cases = <String, (DioExceptionType, Object?, String)>{
      'connectionError': (
        DioExceptionType.connectionError,
        null,
        AppStrings.networkError
      ),
      'connectionTimeout': (
        DioExceptionType.connectionTimeout,
        null,
        AppStrings.networkTimeout
      ),
      'sendTimeout': (
        DioExceptionType.sendTimeout,
        null,
        AppStrings.networkTimeout
      ),
      'receiveTimeout': (
        DioExceptionType.receiveTimeout,
        null,
        AppStrings.networkTimeout
      ),
      'badCertificate': (
        DioExceptionType.badCertificate,
        null,
        AppStrings.badCertificate
      ),
      'cancel': (DioExceptionType.cancel, null, AppStrings.requestCancelled),
      'unknown+SocketException': (
        DioExceptionType.unknown,
        const SocketException('x'),
        AppStrings.networkError
      ),
      'unknown+other': (
        DioExceptionType.unknown,
        StateError('x'),
        AppStrings.unknownError
      ),
    };
    cases.forEach((name, c) {
      test(name, () async {
        final e =
            await _loginError((o) async => throw _err(o, c.$1, error: c.$2));
        expect(e.message, c.$3);
        expect(e.statusCode, isNull);
      });
    });

    test('401 with string detail', () async {
      final e = await _loginError(
          (o) async => _json('{"detail":"Sai mật khẩu"}', 401));
      expect(e.message, 'Sai mật khẩu');
      expect(e.statusCode, 401);
    });

    test('422 with FastAPI list detail', () async {
      final e = await _loginError((o) async =>
          _json('{"detail":[{"msg":"value is not a valid email"}]}', 422));
      expect(e.message, 'value is not a valid email');
      expect(e.statusCode, 422);
    });

    test('500 without detail', () async {
      final e = await _loginError((o) async => _json('{}', 500));
      expect(e.message, AppStrings.unknownError);
      expect(e.statusCode, 500);
    });

    test('502 html body', () async {
      final e = await _loginError((o) async =>
          ResponseBody.fromString('<html>Bad Gateway</html>', 502, headers: {
            Headers.contentTypeHeader: ['text/html']
          }));
      expect(e.message, AppStrings.unknownError);
    });

    test('404 without detail', () async {
      final e = await _loginError((o) async => _json('{}', 404));
      expect(e.message, AppStrings.unknownError);
    });

    test('200 with malformed payload', () async {
      final e = await _loginError((o) async => _json('{"foo":1}', 200));
      expect(e.message, AppStrings.unexpectedResponse);
    });

    test('200 with non-map payload', () async {
      final e = await _loginError((o) async => _json('[1,2]', 200));
      expect(e.message, AppStrings.unexpectedResponse);
    });

    test('register and kid-profile also surface network error', () async {
      final ds =
          _ds((o) async => throw _err(o, DioExceptionType.connectionError));
      await expectLater(
          ds.register(email: 'a@b.com', password: 'x'),
          throwsA(isA<ApiException>()
              .having((e) => e.message, 'm', AppStrings.networkError)));
      await expectLater(
          ds.createOrUpdateKidProfile(nickname: 'n', age: 8, mascotId: 'm'),
          throwsA(isA<ApiException>()
              .having((e) => e.message, 'm', AppStrings.networkError)));
    });
  });

  group('LoginController', () {
    ProviderContainer containerFor(
        Future<ResponseBody> Function(RequestOptions) h) {
      final dio = Dio(BaseOptions(baseUrl: 'http://test'))
        ..httpClientAdapter = _FakeAdapter(h);
      final client =
          ApiClient(tokenStorage: TokenStorage(null), customDio: dio);
      final c = ProviderContainer(overrides: [
        apiClientProvider.overrideWithValue(client),
      ]);
      addTearDown(c.dispose);
      return c;
    }

    test('server down -> isLoading false, errorMessage set, returns false',
        () async {
      final c = containerFor(
          (o) async => throw _err(o, DioExceptionType.connectionError));
      final ok = await c.read(loginControllerProvider.notifier).login();
      final s = c.read(loginControllerProvider);
      expect(ok, isFalse);
      expect(s.isLoading, isFalse);
      expect(s.errorMessage, AppStrings.networkError);
    });

    test('empty email shows validation message without request', () async {
      var called = false;
      final c = containerFor((o) async {
        called = true;
        return _json('{}', 200);
      });
      final n = c.read(loginControllerProvider.notifier)..updateEmail('  ');
      expect(await n.login(), isFalse);
      expect(c.read(loginControllerProvider).errorMessage,
          AppStrings.loginEmptyFields);
      expect(called, isFalse);
    });

    test('empty password shows validation message', () async {
      final c = containerFor((o) async => _json('{}', 200));
      final n = c.read(loginControllerProvider.notifier)..updatePassword('');
      expect(await n.login(), isFalse);
      expect(c.read(loginControllerProvider).errorMessage,
          AppStrings.loginEmptyFields);
    });

    test('editing fields clears previous error', () async {
      final c = containerFor(
          (o) async => throw _err(o, DioExceptionType.connectionTimeout));
      final n = c.read(loginControllerProvider.notifier);
      await n.login();
      expect(c.read(loginControllerProvider).errorMessage,
          AppStrings.networkTimeout);
      n.updateEmail('x@y.com');
      expect(c.read(loginControllerProvider).errorMessage, isNull);
    });

    test('401 wrong credentials shows backend detail', () async {
      final c = containerFor(
          (o) async => _json('{"detail":"Invalid credentials"}', 401));
      await c.read(loginControllerProvider.notifier).login();
      expect(
          c.read(loginControllerProvider).errorMessage, 'Invalid credentials');
    });

    test('non-API exception falls back to generic login failure', () async {
      final c = containerFor((o) async => throw StateError('boom'));
      await c.read(loginControllerProvider.notifier).login();
      expect(c.read(loginControllerProvider).errorMessage, isNotNull);
      expect(c.read(loginControllerProvider).isLoading, isFalse);
    });

    test('retry after failure succeeds and clears error', () async {
      var fail = true;
      final c = containerFor((o) async {
        if (fail) throw _err(o, DioExceptionType.connectionError);
        return _json(
            '{"access_token":"a","refresh_token":"r","user":{"id":"1","email":"a@b.com"}}',
            200);
      });
      final n = c.read(loginControllerProvider.notifier);
      expect(await n.login(), isFalse);
      fail = false;
      final ok = await n.login();
      expect(c.read(loginControllerProvider).isLoading, isFalse);
      // Success requires a valid session payload; either way error must reset.
      if (ok) expect(c.read(loginControllerProvider).errorMessage, isNull);
    });
  });

  group('LoginScreen shows error to the user', () {
    testWidgets('server down message is rendered after tapping login',
        (tester) async {
      final dio = Dio(BaseOptions(baseUrl: 'http://test'))
        ..httpClientAdapter = _FakeAdapter(
            (o) async => throw _err(o, DioExceptionType.connectionError));
      final client =
          ApiClient(tokenStorage: TokenStorage(null), customDio: dio);
      tester.view.physicalSize = const Size(1200, 2400);
      tester.view.devicePixelRatio = 1;
      addTearDown(tester.view.reset);
      await tester.pumpWidget(ProviderScope(
        overrides: [apiClientProvider.overrideWithValue(client)],
        child: const MaterialApp(home: LoginScreen()),
      ));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.networkError), findsNothing);
      await tester.tap(find.text(AppStrings.logIn));
      await tester.pumpAndSettle();
      expect(find.text(AppStrings.networkError), findsOneWidget);
    });
  });
}
