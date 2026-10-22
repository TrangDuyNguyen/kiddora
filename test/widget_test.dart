import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kiddora/app.dart';
import 'package:kiddora/features/onboarding/presentation/controllers/onboarding_controller.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  testWidgets('KiddoraApp renders OnboardingScreen when first launch',
      (tester) async {
    SharedPreferences.setMockInitialValues({'has_completed_onboarding': false});
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const KiddoraApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Kiddora'), findsOneWidget);
    expect(find.text('Learn • Play • Achieve'), findsOneWidget);
    expect(find.text('Fun Learning for a\nBrighter Tomorrow'), findsOneWidget);
  });

  testWidgets('KiddoraApp renders HomeScreen when onboarding completed',
      (tester) async {
    SharedPreferences.setMockInitialValues({
      'has_completed_onboarding': true,
      'kiddora_kid_profile':
          '{"id":"kid_test","nickname":"Keil","age":8,"avatarId":"lion","currentStars":140,"currentStreak":5,"createdAt":"2026-01-01T00:00:00.000"}'
    });
    final prefs = await SharedPreferences.getInstance();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          sharedPreferencesProvider.overrideWithValue(prefs),
        ],
        child: const KiddoraApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Hi, Keil!'), findsOneWidget);
    expect(find.text('Great to see you again!'), findsOneWidget);
    expect(find.text('Keep Learning\nKeep Growing!'), findsOneWidget);
    expect(find.text('My Progress'), findsOneWidget);
    expect(find.text('Current Courses'), findsOneWidget);
    expect(find.text('Upcoming Session'), findsNWidgets(2));
    expect(find.text('My Badges'), findsOneWidget);
    expect(find.text('Amazing Animals'), findsOneWidget);
    expect(find.text('Coach Sarah'), findsOneWidget);
  });
}
