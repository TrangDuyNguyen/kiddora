import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/onboarding/presentation/controllers/onboarding_controller.dart';
import 'package:kiddora/features/onboarding/presentation/pages/onboarding_screen.dart';

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
        home: OnboardingScreen(),
      ),
    );
  }

  group('OnboardingScreen Widget Tests', () {
    testWidgets('Renders Slide 1 elements correctly', (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Brand Title and tagline
      expect(find.text('Kiddora'), findsOneWidget);
      expect(find.text('Learn • Play • Achieve'), findsOneWidget);
      expect(find.text('Bỏ qua'), findsOneWidget);

      // Slide 1 Content
      expect(
          find.text('Fun Learning for a\nBrighter Tomorrow'), findsOneWidget);
      expect(
        find.text(
            'Khám phá khoá học bổ ích, lớp học trực tuyến, chơi vui và rèn luyện tư duy mỗi ngày!'),
        findsOneWidget,
      );

      // Next button icon
      expect(find.byIcon(Icons.arrow_forward_rounded), findsOneWidget);
    });

    testWidgets('Tapping next button advances slide to Slide 2',
        (tester) async {
      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Tap Next button
      await tester.tap(find.byIcon(Icons.arrow_forward_rounded));
      await tester.pumpAndSettle();

      // Slide 2 Content
      expect(
        find.text(
            '${AppStrings.onboardingSlide2TitlePart1}${AppStrings.onboardingSlide2TitlePart2}'),
        findsOneWidget,
      );
    });

    testWidgets('Renders Slide 2 directly with initialPage 1', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: OnboardingScreen(initialPage: 1),
          ),
        ),
      );
      await tester.pump();

      expect(
        find.text(
            '${AppStrings.onboardingSlide2TitlePart1}${AppStrings.onboardingSlide2TitlePart2}'),
        findsOneWidget,
      );
      expect(find.text(AppStrings.chipInteractiveCourses), findsOneWidget);
      expect(find.text(AppStrings.chipFunActivities), findsOneWidget);
      expect(find.text(AppStrings.chipTrackProgress), findsOneWidget);

      tester.takeException();
    });

    testWidgets('Renders Slide 3 directly with initialPage 2', (tester) async {
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            sharedPreferencesProvider.overrideWithValue(prefs),
          ],
          child: const MaterialApp(
            home: OnboardingScreen(initialPage: 2),
          ),
        ),
      );
      await tester.pump();

      expect(
        find.text(
            '${AppStrings.onboardingSlide3TitlePart1}${AppStrings.onboardingSlide3TitlePart2}${AppStrings.onboardingSlide3TitlePart3}'),
        findsOneWidget,
      );
      expect(find.text(AppStrings.chipLiveClassroom), findsOneWidget);
      expect(find.text(AppStrings.chipInteractiveQA), findsOneWidget);
      expect(find.text(AppStrings.chipTopCoaches), findsOneWidget);
      expect(find.text(AppStrings.skip), findsNothing);

      tester.takeException();
    });
  });
}
