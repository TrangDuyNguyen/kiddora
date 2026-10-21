import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
    testWidgets('Renders sections for Nickname, Age, and Avatar', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      expect(find.text('Tạo Hồ Sơ Bé 🎨'), findsOneWidget);
      expect(find.text('Biệt danh của con là gì?'), findsOneWidget);
      expect(find.text('Con mấy tuổi rồi?'), findsOneWidget);
      expect(find.text('Chọn bạn đồng hành 3D:'), findsOneWidget);

      // 4 Ages
      expect(find.text('7 tuổi'), findsOneWidget);
      expect(find.text('8 tuổi'), findsOneWidget);
      expect(find.text('9 tuổi'), findsOneWidget);
      expect(find.text('10 tuổi'), findsOneWidget);

      // 4 Mascots
      expect(find.text('Leo'), findsOneWidget);
      expect(find.text('Barnaby'), findsOneWidget);
      expect(find.text('Dino'), findsOneWidget);
      expect(find.text('Bunny'), findsOneWidget);

      // Action button
      expect(find.text('Khám Phá Kiddora 🚀'), findsOneWidget);
    });

    testWidgets('Entering nickname enables action button', (tester) async {
      tester.view.physicalSize = const Size(1080, 2400);
      tester.view.devicePixelRatio = 2.0;
      addTearDown(() {
        tester.view.resetPhysicalSize();
        tester.view.resetDevicePixelRatio();
      });

      await tester.pumpWidget(buildTestWidget());
      await tester.pump();

      // Enter text
      await tester.enterText(find.byType(TextField), 'Bo');
      await tester.pump();

      // Tap an age
      await tester.tap(find.text('9 tuổi'));
      await tester.pump();

      // Tap a mascot
      await tester.tap(find.text('Dino'));
      await tester.pump();

      // Ensure button is visible before tap
      final buttonFinder = find.text('Khám Phá Kiddora 🚀');
      await tester.ensureVisible(buttonFinder);
      await tester.pumpAndSettle();

      await tester.tap(buttonFinder);
      await tester.pumpAndSettle();

      // Verify saved in SharedPreferences
      expect(prefs.getBool('has_completed_onboarding'), isTrue);
      expect(prefs.getString('kiddora_kid_profile'), contains('Bo'));
    });
  });
}
