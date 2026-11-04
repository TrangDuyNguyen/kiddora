import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/exploration/data/datasources/mock_course_datasource.dart';
import 'package:kiddora/features/exploration/data/repositories/course_repository_impl.dart';
import 'package:kiddora/features/exploration/presentation/pages/course_completed_celebration_screen.dart';
import 'package:kiddora/features/exploration/presentation/pages/course_progress_tracker_screen.dart';

void main() {
  group('CourseProgressTrackerScreen Tests (06_learning_02)', () {
    testWidgets('Renders progress summary, timeline nodes and handles taps',
        (tester) async {
      final mockRepo =
          MockCourseRepository(MockCourseDatasource.getBenchmarkCourses());

      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            courseRepositoryProvider.overrideWithValue(mockRepo),
          ],
          child: const MaterialApp(
            home: CourseProgressTrackerScreen(
              courseId: 'course_amazing_animals',
              courseTitle: 'Amazing Animals',
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 1. Header elements
      expect(find.text('Amazing Animals'), findsOneWidget);

      // 2. Progress summary card
      expect(find.text(AppStrings.overallProgressLabel), findsOneWidget);
      expect(find.text(AppStrings.lessonsCompletedStat), findsOneWidget);
      expect(find.text(AppStrings.starsEarnedStat), findsOneWidget);
      expect(find.text(AppStrings.streakDaysStat), findsOneWidget);

      // 3. Lessons in the pathway
      expect(find.text('Meet the Animals'), findsOneWidget);
      expect(find.text(AppStrings.statusCompleted), findsOneWidget);

      expect(find.text('Animals and Their Habitats'), findsOneWidget);
      expect(find.text(AppStrings.statusInProgress), findsOneWidget);
      expect(find.text(AppStrings.btnContinueCurrentLesson), findsOneWidget);

      expect(find.text('Food and Eating Habits'), findsOneWidget);
      expect(find.text(AppStrings.statusLocked), findsWidgets);

      // 4. Tap locked lesson shows snackbar
      await tester.tap(find.text('Food and Eating Habits'));
      await tester.pump();
      expect(find.text(AppStrings.lessonLockedAlert), findsOneWidget);

      // 5. Tap in-progress lesson button
      await tester.tap(find.text(AppStrings.btnContinueCurrentLesson));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 300));
      expect(
        find.text('Animals and Their Habitats - lesson_anim_02'),
        findsOneWidget,
      );
    });
  });

  group('CourseCompletedCelebrationScreen Tests (06_learning_03)', () {
    testWidgets('Renders celebratory elements, rewards and action buttons',
        (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: CourseCompletedCelebrationScreen(
            courseId: 'course_amazing_animals',
            courseTitle: 'Amazing Animals',
            starsEarned: 50,
          ),
        ),
      );

      await tester.pumpAndSettle();

      // 1. Header & Course Title
      expect(find.text('Amazing Animals'), findsOneWidget);
      expect(find.text(AppStrings.celebrationTitle), findsOneWidget);
      expect(find.text(AppStrings.courseCompletedHeading), findsOneWidget);
      expect(find.text(AppStrings.courseCompletedSubheading), findsOneWidget);

      // 2. Reward items
      expect(find.text(AppStrings.starsRewardTotal), findsOneWidget);
      expect(find.text(AppStrings.streakBonusText), findsOneWidget);
      expect(find.text(AppStrings.badgeEarnedTitle), findsOneWidget);

      // 3. Action Buttons
      expect(find.text(AppStrings.btnViewProgressTracker), findsOneWidget);
      expect(find.text(AppStrings.btnBackToHome), findsOneWidget);

      // 4. Tap action buttons (verify no errors)
      await tester.tap(find.text(AppStrings.btnViewProgressTracker));
      await tester.pumpAndSettle();

      await tester.tap(find.text(AppStrings.btnBackToHome));
      await tester.pumpAndSettle();
    });
  });
}
