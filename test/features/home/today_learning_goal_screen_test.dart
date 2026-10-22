import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kiddora/core/constants/app_strings.dart';
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

      expect(find.text(AppStrings.todaysLearningGoal), findsOneWidget);
      expect(find.text(AppStrings.todaysGoalSubtitle), findsOneWidget);
      expect(find.text('3${AppStrings.ofSeparator}5'), findsOneWidget);
      expect(find.text(AppStrings.tasksCompleted), findsOneWidget);

      expect(find.text(AppStrings.taskWatchLesson), findsOneWidget);
      expect(find.text(AppStrings.courseAmazingAnimals), findsOneWidget);
      expect(find.text(AppStrings.taskCompleteQuiz), findsOneWidget);
      expect(find.text(AppStrings.taskAnimalFactsQuiz), findsOneWidget);
      expect(find.text(AppStrings.taskJoinLiveSession), findsOneWidget);
      expect(find.text(AppStrings.mathFunWithNumbers), findsOneWidget);
      expect(find.text(AppStrings.taskReadStory), findsOneWidget);
      expect(find.text(AppStrings.taskMysteryOfSpace), findsOneWidget);
      expect(find.text(AppStrings.taskEarnPoints), findsOneWidget);
      expect(find.text(AppStrings.taskKeepGoing), findsOneWidget);

      expect(find.text(AppStrings.youCanDoIt), findsOneWidget);
      expect(find.text(AppStrings.reachGoalToday), findsOneWidget);
    });

    testWidgets(
        'toggles an incomplete task and dynamically updates counter to 4 of 5',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget());
      await tester.pumpAndSettle();

      expect(find.text('3${AppStrings.ofSeparator}5'), findsOneWidget);

      // Tap on incomplete task "Read a story"
      final readStoryTask = find.text(AppStrings.taskReadStory);
      await tester.tap(readStoryTask);
      await tester.pumpAndSettle();

      // Should now update dynamically to "4 of 5"
      expect(find.text('4${AppStrings.ofSeparator}5'), findsOneWidget);
    });
  });
}
