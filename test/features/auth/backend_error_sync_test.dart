import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/core/network/api_client.dart';
import 'package:kiddora/core/network/token_storage.dart';
import 'package:kiddora/features/auth/presentation/controllers/register_controller.dart';
import 'package:kiddora/features/auth/presentation/login_screen.dart';
import 'package:kiddora/features/auth/presentation/register_screen.dart';
import 'package:kiddora/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:kiddora/features/onboarding/presentation/pages/kid_profile_setup_screen.dart';

typedef _Handler = Future<ResponseBody> Function(RequestOptions);

class _Adapter implements HttpClientAdapter {
  _Adapter(this.h);
  final _Handler h;
  @override
  Future<ResponseBody> fetch(RequestOptions o, Stream<List<int>>? s,
          Future<void>? c) =>
      h(o);
  @override
  void close({bool force = false}) {}
}

ResponseBody _json(String b, int s) => ResponseBody.fromString(b, s, headers: {
      Headers.contentTypeHeader: [Headers.jsonContentType],
    });

Future<ResponseBody> _down(RequestOptions o) async => throw DioException(
    requestOptions: o, type: DioExceptionType.connectionError);

const _beMsg = 'Email đã được sử dụng';
Future<ResponseBody> _conflict(RequestOptions o) async =>
    _json('{"detail":"$_beMsg"}', 409);

Future<ResponseBody> _validation(RequestOptions o) async =>
    _json('{"detail":"Dữ liệu không hợp lệ (email): sai định dạng"}', 422);

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;
  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  ProviderContainer container(_Handler h, {TokenStorage? tokens}) {
    final ts = tokens ?? TokenStorage(null);
    final dio = Dio(BaseOptions(baseUrl: 'http://test'))
      ..httpClientAdapter = _Adapter(h);
    final c = ProviderContainer(overrides: [
      sharedPreferencesProvider.overrideWithValue(prefs),
      tokenStorageProvider.overrideWithValue(ts),
      apiClientProvider
          .overrideWithValue(ApiClient(tokenStorage: ts, customDio: dio)),
    ]);
    addTearDown(c.dispose);
    return c;
  }

  void fillRegister(RegisterController n) => n
    ..updateFullName('An')
    ..updateEmail('a@b.com')
    ..updatePassword('Password1')
    ..updateConfirmPassword('Password1')
    ..toggleAgreeTerms();

  group('RegisterController shows backend message as-is', () {
    test('409 -> exact BE detail', () async {
      final c = container(_conflict);
      final n = c.read(registerControllerProvider.notifier);
      fillRegister(n);
      expect(await n.register(), isFalse);
      final s = c.read(registerControllerProvider);
      expect(s.errorMessage, _beMsg);
      expect(s.isLoading, isFalse);
    });

    test('422 -> exact BE detail', () async {
      final c = container(_validation);
      final n = c.read(registerControllerProvider.notifier);
      fillRegister(n);
      await n.register();
      expect(c.read(registerControllerProvider).errorMessage,
          'Dữ liệu không hợp lệ (email): sai định dạng');
    });

    test('server down -> network message', () async {
      final c = container(_down);
      final n = c.read(registerControllerProvider.notifier);
      fillRegister(n);
      await n.register();
      expect(c.read(registerControllerProvider).errorMessage,
          AppStrings.networkError);
    });

    test('client validations never hit the network', () async {
      var hit = false;
      final c = container((o) async {
        hit = true;
        return _json('{}', 200);
      });
      final n = c.read(registerControllerProvider.notifier);
      expect(await n.register(), isFalse);
      expect(c.read(registerControllerProvider).errorMessage,
          AppStrings.pleaseFillAllFields);
      n
        ..updateFullName('An')
        ..updateEmail('a@b.com')
        ..updatePassword('123')
        ..updateConfirmPassword('123');
      await n.register();
      expect(c.read(registerControllerProvider).errorMessage,
          AppStrings.passwordTooShort);
      n
        ..updatePassword('Password1')
        ..updateConfirmPassword('Other1234');
      await n.register();
      expect(c.read(registerControllerProvider).errorMessage,
          AppStrings.passwordsDoNotMatch);
      n.updateConfirmPassword('Password1');
      await n.register();
      expect(c.read(registerControllerProvider).errorMessage,
          AppStrings.mustAgreeTerms);
      expect(hit, isFalse);
    });
  });

  group('OnboardingController (kid profile) error sync', () {
    Future<ProviderContainer> loggedIn(_Handler h) async {
      final ts = TokenStorage(null);
      await ts.saveTokens(accessToken: 'tok', refreshToken: 'ref');
      return container(h, tokens: ts);
    }

    test('BE detail is surfaced', () async {
      final c = await loggedIn(
          (o) async => _json('{"detail":"Token không hợp lệ hoặc đã hết hạn"}', 401));
      final n = c.read(onboardingControllerProvider.notifier)
        ..updateNickname('Bé Na');
      expect(await n.completeOnboarding(), isFalse);
      final s = c.read(onboardingControllerProvider);
      expect(s.errorMessage, 'Token không hợp lệ hoặc đã hết hạn');
      expect(s.isLoading, isFalse);
    });

    test('server down -> network message, retry clears error', () async {
      var down = true;
      final c = await loggedIn((o) async {
        if (down) return _down(o);
        return _json(
            '{"id":"1","nickname":"Na","age":8,"mascot_id":"lion","current_stars":0,"current_streak":0}',
            200);
      });
      final n = c.read(onboardingControllerProvider.notifier)
        ..updateNickname('Bé Na');
      expect(await n.completeOnboarding(), isFalse);
      expect(c.read(onboardingControllerProvider).errorMessage,
          AppStrings.networkError);
      down = false;
      await n.completeOnboarding();
      expect(c.read(onboardingControllerProvider).errorMessage, isNull);
    });

    test('invalid nickname returns false without error or request', () async {
      final c = await loggedIn(_down);
      final n = c.read(onboardingControllerProvider.notifier)
        ..updateNickname('A');
      expect(await n.completeOnboarding(), isFalse);
      expect(c.read(onboardingControllerProvider).errorMessage, isNull);
    });

    test('guest mode saves locally with no error', () async {
      final c = container(_down);
      final n = c.read(onboardingControllerProvider.notifier)
        ..updateNickname('Bé Na');
      expect(await n.completeOnboarding(), isTrue);
      expect(c.read(onboardingControllerProvider).errorMessage, isNull);
    });
  });

  group('Screens render the backend message', () {
    void bigView(WidgetTester t) {
      t.view.physicalSize = const Size(1200, 3000);
      t.view.devicePixelRatio = 1;
      addTearDown(t.view.reset);
    }

    Future<void> pump(WidgetTester t, Widget home, _Handler h) async {
      bigView(t);
      final dio = Dio(BaseOptions(baseUrl: 'http://test'))
        ..httpClientAdapter = _Adapter(h);
      final ts = TokenStorage(null);
      await ts.saveTokens(accessToken: 'tok', refreshToken: 'ref');
      await t.pumpWidget(ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
          tokenStorageProvider.overrideWithValue(ts),
          apiClientProvider
              .overrideWithValue(ApiClient(tokenStorage: ts, customDio: dio)),
        ],
        child: MaterialApp(home: home),
      ));
      await t.pumpAndSettle();
    }

    testWidgets('Login: BE 401 message', (t) async {
      await pump(
          t,
          const LoginScreen(),
          (o) async => _json(
              '{"detail":"Email hoặc mật khẩu không chính xác"}', 401));
      await t.tap(find.text(AppStrings.logIn));
      await t.pumpAndSettle();
      expect(find.text('Email hoặc mật khẩu không chính xác'), findsOneWidget);
    });

    testWidgets('Register: BE 409 message', (t) async {
      await pump(t, const RegisterScreen(), _conflict);
      final container =
          ProviderScope.containerOf(t.element(find.byType(RegisterScreen)));
      fillRegister(container.read(registerControllerProvider.notifier));
      await t.pump();
      await t.tap(find.text(AppStrings.signUp).last);
      await t.pumpAndSettle();
      expect(find.text(_beMsg), findsOneWidget);
    });

    testWidgets('Kid profile: BE message shown', (t) async {
      await pump(
          t,
          const KidProfileSetupScreen(),
          (o) async => _json('{"detail":"Người dùng không tồn tại"}', 404));
      final container = ProviderScope.containerOf(
          t.element(find.byType(KidProfileSetupScreen)));
      container.read(onboardingControllerProvider.notifier).updateNickname('Bé Na');
      await t.pump();
      await t.ensureVisible(find.text(AppStrings.readyToExplore));
      await t.tap(find.text(AppStrings.readyToExplore));
      await t.pumpAndSettle();
      expect(find.text('Người dùng không tồn tại'), findsOneWidget);
    });
  });
}
