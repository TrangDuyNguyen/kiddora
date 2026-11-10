import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/classroom/presentation/sessions_hub_body.dart';
import 'package:kiddora/features/exploration/presentation/practice_tests_hub_body.dart';
import 'package:kiddora/features/parent_hub/presentation/student_profile_body.dart';

void main() {
  group('Main Tabs Bodies Tests', () {
    testWidgets('SessionsHubBody renders banner, day filter and upcoming sessions',
        (tester) async {
      String? snackMessage;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: SessionsHubBody(
              onSnack: (msg) => snackMessage = msg,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.sessionsHubTitle), findsOneWidget);
      expect(find.text(AppStrings.liveNowBadge), findsOneWidget);
      expect(find.text(AppStrings.liveNowTitle), findsOneWidget);
      expect(find.text(AppStrings.upcomingSessionsTitle), findsOneWidget);

      // Tap join live now
      await tester.tap(find.text(AppStrings.btnJoinLiveNow));
      await tester.pump();
      expect(snackMessage, AppStrings.joiningSessionAlert);

      // Tap day filter
      await tester.tap(find.text(AppStrings.tabTomorrow));
      await tester.pumpAndSettle();
    });

    testWidgets('PracticeTestsHubBody renders scoreboard, categories and recommended tests',
        (tester) async {
      String? snackMessage;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: PracticeTestsHubBody(
              onSnack: (msg) => snackMessage = msg,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text(AppStrings.testsHubTitle), findsOneWidget);
      expect(find.text(AppStrings.statCompletedTests), findsOneWidget);
      expect(find.text(AppStrings.testCategoryTitle), findsOneWidget);
      expect(find.text(AppStrings.recommendedTestsTitle), findsOneWidget);

      // Tap start test
      await tester.tap(find.text(AppStrings.btnStartTest).first);
      await tester.pump();
      expect(snackMessage, contains(AppStrings.btnStartTest));
    });

    testWidgets('StudentProfileBody renders hero card, stats, parent gate and settings',
        (tester) async {
      bool logoutTapped = false;
      String? snackMessage;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: StudentProfileBody(
              nickname: 'Keil',
              age: 9,
              onLogoutTap: () => logoutTapped = true,
              onSnack: (msg) => snackMessage = msg,
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('Keil'), findsOneWidget);
      expect(find.text('9 ${AppStrings.ageUnit}'), findsOneWidget);
      expect(find.text(AppStrings.statStarPoints), findsOneWidget);
      expect(find.text(AppStrings.parentGateCardTitle), findsOneWidget);
      expect(find.text(AppStrings.settingsSectionTitle), findsOneWidget);

      // Tap unlock parent gate
      await tester.tap(find.text(AppStrings.btnUnlockParentGate));
      await tester.pump();
      expect(snackMessage, AppStrings.parentGateCardTitle);

      // Tap logout setting (scroll into view first)
      await tester.scrollUntilVisible(
        find.text(AppStrings.settingLogout),
        200,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.text(AppStrings.settingLogout));
      await tester.pump();
      expect(logoutTapped, isTrue);
    });
  });
}
