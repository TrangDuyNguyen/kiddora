import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/exploration/data/datasources/mock_course_datasource.dart';
import 'package:kiddora/features/exploration/data/repositories/course_repository_impl.dart';
import 'package:kiddora/features/exploration/presentation/course_filter_sheet.dart';

void main() {
  testWidgets('CourseFilterScreen renders 4 filter groups and handles clear & apply',
      (tester) async {
    final mockRepo = MockCourseRepository(MockCourseDatasource.getBenchmarkCourses());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          courseRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: const MaterialApp(
          home: CourseFilterScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Header & Clear All
    expect(find.text(AppStrings.filterCoursesTitle), findsOneWidget);
    expect(find.text(AppStrings.filterClearAll), findsOneWidget);

    // 2. 4 Filter Groups
    expect(find.text(AppStrings.filterSectionProgram), findsOneWidget);
    expect(find.text(AppStrings.filterSectionAgeGroup), findsOneWidget);
    expect(find.text(AppStrings.filterSectionLevel), findsOneWidget);
    expect(find.text(AppStrings.filterSectionDuration), findsOneWidget);

    // 3. Check some specific chips
    expect(find.text(AppStrings.subjectScience), findsOneWidget);
    expect(find.text(AppStrings.filterAge7to8), findsOneWidget);
    expect(find.text(AppStrings.levelBeginner), findsOneWidget);
    expect(find.text(AppStrings.durationShort), findsOneWidget);

    // 4. Tap Science and Beginner
    await tester.tap(find.text(AppStrings.subjectScience));
    await tester.pumpAndSettle();

    await tester.tap(find.text(AppStrings.levelBeginner));
    await tester.pumpAndSettle();

    // 5. Tap Clear All
    await tester.tap(find.text(AppStrings.filterClearAll));
    await tester.pumpAndSettle();

    // 6. Tap Apply Filters button
    expect(find.text(AppStrings.filterApply), findsOneWidget);
    await tester.tap(find.text(AppStrings.filterApply));
    await tester.pumpAndSettle();
  });
}
