import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/home/presentation/home_screen.dart';
import 'package:kiddora/features/onboarding/presentation/controllers/onboarding_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late SharedPreferences prefs;

  setUp(() async {
    SharedPreferences.setMockInitialValues({
      'has_completed_onboarding': true,
      'kiddora_kid_profile':
          '{"id":"kid_test","nickname":"Keil","age":8,"avatarId":"lion","currentStars":140,"currentStreak":5,"createdAt":"2026-01-01T00:00:00.000"}'
    });
    prefs = await SharedPreferences.getInstance();
  });

  Widget buildTestableWidget() {
    return ProviderScope(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(prefs),
      ],
      child: const MaterialApp(
        home: HomeScreen(),
      ),
    );
  }

  group('HomeScreen (Screen 2 1:1 Benchmark) Tests', () {
    testWidgets('renders greeting, hero banner, quick stats, and 5-tab nav',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(
        find.text(
          '${AppStrings.hiPrefix}Keil${AppStrings.exclamationMark}',
        ),
        findsOneWidget,
      );
      expect(find.text(AppStrings.greatToSeeYou), findsOneWidget);
      expect(find.text(AppStrings.notificationCount), findsOneWidget);
      expect(find.text(AppStrings.keepLearningHeroTitle), findsOneWidget);
      expect(find.text(AppStrings.keepLearningHeroSubtitle), findsOneWidget);
      expect(find.text(AppStrings.myProgress), findsOneWidget);
      expect(find.text(AppStrings.currentCourses), findsOneWidget);
      expect(find.text(AppStrings.upcomingSession), findsNWidgets(2));
      expect(find.text(AppStrings.myBadges), findsOneWidget);
      expect(find.text(AppStrings.continueLearning), findsOneWidget);
      expect(find.text(AppStrings.courseAmazingAnimals), findsOneWidget);
      expect(find.text(AppStrings.courseLessonsProgress), findsOneWidget);
      expect(find.text(AppStrings.mathFunWithNumbers), findsOneWidget);
      expect(find.text(AppStrings.coachSarah), findsOneWidget);
      expect(find.text(AppStrings.join), findsOneWidget);
      expect(find.text(AppStrings.navHome), findsOneWidget);
      expect(find.text(AppStrings.navCourses), findsOneWidget);
      expect(find.text(AppStrings.navSessions), findsOneWidget);
      expect(find.text(AppStrings.navTests), findsOneWidget);
      expect(find.text(AppStrings.navProfile), findsOneWidget);
    });

    testWidgets('bottom navigation switches tab index and opens Empty Sessions modal',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.text(AppStrings.navSessions));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.modalNoSessionsTitle), findsOneWidget);
      expect(find.text(AppStrings.modalExploreCourses), findsOneWidget);
      expect(find.text(AppStrings.modalMaybeLater), findsOneWidget);

      await tester.tap(find.text(AppStrings.modalExploreCourses));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.modalNoSessionsTitle), findsNothing);
    });

    testWidgets('logout icon opens Logout confirmation modal and cancels cleanly',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      await tester.tap(find.byIcon(Icons.logout_rounded));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.modalLogoutTitle), findsOneWidget);
      expect(find.text(AppStrings.modalLogoutConfirm), findsOneWidget);
      expect(find.text(AppStrings.modalCancel), findsOneWidget);

      await tester.tap(find.text(AppStrings.modalCancel));
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.modalLogoutTitle), findsNothing);
    });
  });
}
