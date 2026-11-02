import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/exploration/data/datasources/mock_course_datasource.dart';
import 'package:kiddora/features/exploration/data/repositories/course_repository_impl.dart';
import 'package:kiddora/features/exploration/presentation/courses_hub_body.dart';

void main() {
  testWidgets('CoursesHubBody renders header, hero banner, category chips and popular courses',
      (tester) async {
    final mockRepo = MockCourseRepository(MockCourseDatasource.getBenchmarkCourses());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          courseRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: const MaterialApp(
          home: Scaffold(
            body: SafeArea(
              child: CoursesHubBody(),
            ),
          ),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Header elements
    expect(find.text(AppStrings.coursesHubTitle), findsOneWidget);
    expect(find.text(AppStrings.coursesHubSubtitle), findsOneWidget);
    expect(find.byIcon(Icons.search_rounded), findsOneWidget);

    // 2. Hero Banner
    expect(find.text(AppStrings.brighterFutureTitle), findsOneWidget);
    expect(find.text(AppStrings.brighterFutureSubtitle), findsOneWidget);

    // 3. Category cards
    expect(find.text(AppStrings.subjectAll), findsOneWidget);
    expect(find.text(AppStrings.subjectScience), findsOneWidget);
    expect(find.text(AppStrings.subjectMath), findsOneWidget);
    expect(find.text(AppStrings.subjectLanguage), findsOneWidget);
    expect(find.text(AppStrings.subjectArts), findsOneWidget);

    // 4. Popular Courses section header
    expect(find.text(AppStrings.popularCoursesTitle), findsOneWidget);
    expect(find.text(AppStrings.seeAll), findsOneWidget);

    // 5. Check popular courses in 2-column grid
    expect(find.text('Amazing Animals'), findsOneWidget);
    expect(find.text('Space Exploration'), findsOneWidget);

    // 6. Test Category Filter tap
    await tester.tap(find.text(AppStrings.subjectMath));
    await tester.pumpAndSettle();
    expect(find.text('Math Fun with Numbers'), findsOneWidget);
  });
}

