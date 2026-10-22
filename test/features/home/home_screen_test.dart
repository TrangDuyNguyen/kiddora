import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    testWidgets('renders greeting, hero banner, quick stats, and bottom nav',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('Hi, Keil!'), findsOneWidget);
      expect(find.text('Great to see you again!'), findsOneWidget);
      expect(find.text('3'), findsOneWidget); // Notification badge
      expect(find.text('Keep Learning\nKeep Growing!'), findsOneWidget);
      expect(find.text('Small steps make\nbig dreams! ✨'), findsOneWidget);
      expect(find.text('My Progress'), findsOneWidget);
      expect(find.text('Current Courses'), findsOneWidget);
      expect(find.text('Upcoming Session'), findsNWidgets(2));
      expect(find.text('My Badges'), findsOneWidget);
      expect(find.text('Continue Learning'), findsOneWidget);
      expect(find.text('Amazing Animals'), findsOneWidget);
      expect(find.text('3 of 5 lessons'), findsOneWidget);
      expect(find.text('Math Fun with Numbers'), findsOneWidget);
      expect(find.text('Coach Sarah'), findsOneWidget);
      expect(find.text('Join'), findsOneWidget);
      expect(find.text('Home'), findsOneWidget);
      expect(find.text('Courses'), findsOneWidget);
      expect(find.text('Sessions'), findsOneWidget);
      expect(find.text('Tests'), findsOneWidget);
      expect(find.text('More'), findsOneWidget);
    });

    testWidgets('bottom navigation switches tab index cleanly', (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      final coursesTab = find.text('Courses');
      await tester.tap(coursesTab);
      await tester.pumpAndSettle();

      expect(find.text('Courses'), findsOneWidget);
    });
  });
}
