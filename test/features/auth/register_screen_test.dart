import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/auth/presentation/register_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: RegisterScreen(),
      ),
    );
  }

  group('RegisterScreen (Sign Up Flow) Tests', () {
    testWidgets('renders all visual elements correctly', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.learnPlayAchieve), findsOneWidget);
      expect(find.text(AppStrings.createAccount), findsOneWidget);
      expect(find.text(AppStrings.createAccountSubtitle), findsOneWidget);
      expect(find.text(AppStrings.fullName), findsOneWidget);
      expect(find.text(AppStrings.emailAddress), findsOneWidget);
      expect(find.text(AppStrings.password), findsOneWidget);
      expect(find.text(AppStrings.confirmPassword), findsOneWidget);
      expect(find.text(AppStrings.agreeTerms), findsOneWidget);
      expect(find.text(AppStrings.signUp), findsOneWidget);
      expect(find.text(AppStrings.orSignUpWith), findsOneWidget);
      expect(find.text(AppStrings.alreadyHaveAccount), findsOneWidget);
      expect(find.text(AppStrings.logIn), findsOneWidget);
    });

    testWidgets('toggles password obscurity upon tapping eye icon',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      final eyeIcons = find.byIcon(Icons.visibility_outlined);
      expect(eyeIcons, findsNWidgets(2)); // Password & Confirm Password

      await tester.tap(eyeIcons.first);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.visibility_off_outlined), findsOneWidget);
    });

    testWidgets('toggles terms and conditions checkbox', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_rounded), findsNothing);

      final agreeTermsText = find.text(AppStrings.agreeTerms);
      await tester.ensureVisible(agreeTermsText);
      await tester.tap(agreeTermsText);
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check_rounded), findsOneWidget);
    });

    testWidgets('shows validation error when fields are empty upon tapping sign up',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      final signUpButton = find.text(AppStrings.signUp);
      await tester.ensureVisible(signUpButton);
      await tester.tap(signUpButton);
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.pleaseFillAllFields), findsOneWidget);
    });

    testWidgets('renders cleanly on compact mobile screen without overflows',
        (tester) async {
      tester.view.physicalSize = const Size(360, 690);
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
