import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/auth/presentation/login_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: LoginScreen(),
      ),
    );
  }

  group('LoginScreen (Screen 1 1:1 Benchmark) Tests', () {
    testWidgets('renders all visual elements correctly', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.learnPlayAchieve), findsOneWidget);
      expect(find.text(AppStrings.welcomeBack), findsOneWidget);
      expect(find.text(AppStrings.welcomeBackSubtitle), findsOneWidget);
      expect(find.text(AppStrings.emailOrUsername), findsOneWidget);
      expect(find.text(AppStrings.password), findsOneWidget);
      expect(find.text(AppStrings.rememberMe), findsOneWidget);
      expect(find.text(AppStrings.forgotPassword), findsOneWidget);
      expect(find.text(AppStrings.logIn), findsOneWidget);
      expect(find.text(AppStrings.orContinueWith), findsOneWidget);
      expect(find.text(AppStrings.signUp), findsOneWidget);
    });

    testWidgets('toggles password obscurity upon tapping eye icon',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      final eyeIcon = find.byIcon(Icons.visibility_outlined);
      expect(eyeIcon, findsOneWidget);

      await tester.tap(eyeIcon);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('toggles remember me checkbox', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_rounded), findsOneWidget);

      final rememberMeText = find.text(AppStrings.rememberMe);
      await tester.tap(rememberMeText);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_rounded), findsNothing);
    });
  });
}
