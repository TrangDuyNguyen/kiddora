import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddora/features/home/presentation/today_learning_goal_screen.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  Widget buildTestableWidget() {
    return const ProviderScope(
      child: MaterialApp(
        home: TodayLearningGoalScreen(),
      ),
    );
  }

  group('TodayLearningGoalScreen (Screen 3 1:1 Benchmark) Tests', () {
    testWidgets('renders all circular progress, tasks and motivation elements',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text("Today's Learning Goal"), findsOneWidget);
      expect(find.text('Small steps make big progress!'), findsOneWidget);
      expect(find.text('3 of 5'), findsOneWidget);
      expect(find.text('Tasks Completed'), findsOneWidget);

      expect(find.text('Watch a lesson'), findsOneWidget);
      expect(find.text('Amazing Animals'), findsOneWidget);
      expect(find.text('Complete a quiz'), findsOneWidget);
      expect(find.text('Animal Facts Quiz'), findsOneWidget);
      expect(find.text('Join a live session'), findsOneWidget);
      expect(find.text('Math Fun with Numbers'), findsOneWidget);
      expect(find.text('Read a story'), findsOneWidget);
      expect(find.text('The Mystery of Space'), findsOneWidget);
      expect(find.text('Earn 10 points'), findsOneWidget);
      expect(find.text('Keep going!'), findsOneWidget);

      expect(find.text('You can do it!'), findsOneWidget);
      expect(
        find.text('Keep learning and reach your goal today!'),
        findsOneWidget,
      );
    });

    testWidgets('toggles an incomplete task and dynamically updates counter to 4 of 5',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('3 of 5'), findsOneWidget);

      // Tap on incomplete task "Read a story"
      final readStoryTask = find.text('Read a story');
      await tester.tap(readStoryTask);
      await tester.pumpAndSettle();

      // Should now update dynamically to "4 of 5"
      expect(find.text('4 of 5'), findsOneWidget);
    });
  });
}
