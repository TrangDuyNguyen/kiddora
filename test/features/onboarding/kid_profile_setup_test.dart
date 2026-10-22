import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/core/constants/app_values.dart';
import 'package:kiddora/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:kiddora/features/onboarding/presentation/pages/kid_profile_setup_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    prefs = await SharedPreferences.getInstance();
  });

  Widget buildTestWidget() {
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MaterialApp(
        home: KidProfileSetupScreen(),
      ),
    );
  }

  group('KidProfileSetupScreen Widget Tests', () {
    testWidgets('Renders sections for Nickname, Quick Chips, Age Spinner, and Avatar',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text(AppStrings.setupProfileTitle), findsOneWidget);
      expect(find.text(AppStrings.nicknameLabel), findsOneWidget);
      expect(find.text(AppStrings.ageQuestion), findsOneWidget);
      expect(find.text(AppStrings.selectCompanion), findsOneWidget);

      // Quick Nickname chips
      for (final nick in AppValues.quickNicknames) {
        expect(find.text(nick), findsOneWidget);
      }
      expect(find.byIcon(Icons.casino_rounded), findsOneWidget);

      // Default curriculum hint for age 8
      expect(find.text(AppStrings.curriculumHintForAge(8)), findsOneWidget);

      // Category Switcher
      expect(find.text(AppStrings.zodiacTabTitle), findsOneWidget);
      expect(find.text(AppStrings.classicTabTitle), findsOneWidget);

      // 12 Zodiac Mascots rendered on Zodiac tab
      expect(find.text(AppStrings.zodiacTy), findsOneWidget);
      expect(find.text(AppStrings.zodiacSuu), findsOneWidget);
      expect(find.text(AppStrings.zodiacThin), findsOneWidget);

      // Switch to Classic Companions tab
      await tester.tap(find.text(AppStrings.classicTabTitle));
      await tester.pumpAndSettle();

      // 4 Classic Mascots
      expect(find.text('Leo'), findsOneWidget);
      expect(find.text('Barnaby'), findsOneWidget);
      expect(find.text('Dino'), findsOneWidget);
      expect(find.text('Bunny'), findsOneWidget);

      // Action button
      expect(find.text(AppStrings.readyToExplore), findsOneWidget);
    });

    testWidgets('Tapping quick nickname chip fills name and enables action button',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Tap 'Bắp' quick chip
      await tester.tap(find.text('Bắp'));
      await tester.pump();

      final textField = tester.widget<TextField>(find.byType(TextField));
      expect(textField.controller?.text, equals('Bắp'));

      // Tap mascot (Zodiac mascot Tý - Chuột in first row)
      await tester.tap(find.text(AppStrings.zodiacTy));
      await tester.pump();

      // Ensure button is visible before tap
      final buttonFinder = find.text(AppStrings.readyToExplore);
      await tester.ensureVisible(buttonFinder);
      await tester.pumpAndSettle();

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Verify saved in SharedPreferences
      expect(prefs.getBool('has_completed_onboarding'), isTrue);
      expect(prefs.getString('kiddora_kid_profile'), contains('Bắp'));
    });

    testWidgets('Tapping dice button populates a valid random nickname',
        (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Tap dice button
      await tester.tap(find.byIcon(Icons.casino_rounded));
      await tester.pump();

      final textField = tester.widget<TextField>(find.byType(TextField));
      final generatedName = textField.controller?.text ?? '';
      expect(generatedName.isNotEmpty, isTrue);
      expect(AppValues.randomNicknames.contains(generatedName), isTrue);
    });
  });
}
