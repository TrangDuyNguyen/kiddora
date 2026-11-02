import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/exploration/data/datasources/mock_course_datasource.dart';
import 'package:kiddora/features/exploration/data/repositories/course_repository_impl.dart';
import 'package:kiddora/features/exploration/presentation/course_curriculum_screen.dart';
import 'package:kiddora/features/exploration/presentation/course_detail_screen.dart';

void main() {
  testWidgets('CourseDetailScreen renders overview, pills, rating, 4 features and start button',
      (tester) async {
    final mockRepo = MockCourseRepository(MockCourseDatasource.getBenchmarkCourses());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          courseRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: const MaterialApp(
          home: CourseDetailScreen(courseId: 'course_amazing_animals'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Overview header elements
    expect(find.text('Amazing Animals'), findsOneWidget);
    expect(find.text('SCIENCE'), findsOneWidget);
    expect(find.text('${AppStrings.agesPrefix} 7–10'), findsOneWidget);
    expect(find.text('5 ${AppStrings.lessonsCountSuffix}'), findsOneWidget);

    // 2. Rating row
    expect(find.textContaining('4.8'), findsOneWidget);

    // 3. About section
    expect(find.text(AppStrings.aboutThisCourseHeader), findsOneWidget);

    // 4. 4 Feature cards
    expect(find.text(AppStrings.featureFunVideos), findsOneWidget);
    expect(find.text(AppStrings.featureInteractiveQuizzes), findsOneWidget);
    expect(find.text(AppStrings.featureActivitySheets), findsOneWidget);
    expect(find.text(AppStrings.featureEarnBadges), findsOneWidget);

    // 5. Start Learning CTA button
    expect(find.text(AppStrings.startLearning), findsOneWidget);
  });

  testWidgets('CourseCurriculumScreen renders 3 tabs, 5 lessons and badge banner',
      (tester) async {
    final mockRepo = MockCourseRepository(MockCourseDatasource.getBenchmarkCourses());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          courseRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: const MaterialApp(
          home: CourseCurriculumScreen(courseId: 'course_amazing_animals'),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Compact header
    expect(find.text('Amazing Animals'), findsOneWidget);
    expect(find.text('5 ${AppStrings.lessonsCountSuffix} • SCIENCE'), findsOneWidget);

    // 2. 3 Tabs Pill
    expect(find.text(AppStrings.tabLessons), findsOneWidget);
    expect(find.text(AppStrings.tabAbout), findsOneWidget);
    expect(find.text(AppStrings.tabReviews), findsOneWidget);

    // 3. 5 Lessons in the curriculum
    expect(find.text('Meet the Animals'), findsOneWidget);
    expect(find.text('Animals and Their Habitats'), findsOneWidget);
    expect(find.text('Food and Eating Habits'), findsOneWidget);
    expect(find.text('Animal Life Cycles'), findsOneWidget);
    expect(find.text('How We Can Help'), findsOneWidget);

    // 4. Badge Banner
    expect(find.text(AppStrings.completeLessonsBadgeBanner), findsOneWidget);

    // 5. Tap unlocked lesson 2 -> shows demo notice snackbar
    await tester.tap(find.text('Animals and Their Habitats'));
    await tester.pump();
    expect(find.text(AppStrings.lessonDemoNotice), findsOneWidget);

    // 6. Scroll to locked lesson 3 and tap -> shows locked alert snackbar
    await tester.scrollUntilVisible(find.text('Food and Eating Habits'), 100);
    await tester.tap(find.text('Food and Eating Habits'));
    await tester.pump();
    expect(find.text(AppStrings.lessonLockedAlert), findsOneWidget);

    // 7. Switch to About Tab
    await tester.tap(find.text(AppStrings.tabAbout));
    await tester.pumpAndSettle();
    expect(find.text(AppStrings.aboutThisCourseHeader), findsOneWidget);

    // 8. Switch to Reviews Tab
    await tester.tap(find.text(AppStrings.tabReviews));
    await tester.pumpAndSettle();
    expect(find.textContaining('4.8 / 5.0'), findsOneWidget);
  });
}
