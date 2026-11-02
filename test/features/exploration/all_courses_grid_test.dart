import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/exploration/data/datasources/mock_course_datasource.dart';
import 'package:kiddora/features/exploration/data/repositories/course_repository_impl.dart';
import 'package:kiddora/features/exploration/presentation/all_courses_grid_screen.dart';

void main() {
  testWidgets('AllCoursesGridScreen renders 6 benchmark courses and allows favorite toggle',
      (tester) async {
    final mockRepo = MockCourseRepository(MockCourseDatasource.getBenchmarkCourses());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          courseRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: const MaterialApp(
          home: AllCoursesGridScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Header & Filter Bar
    expect(find.text(AppStrings.allCoursesTitle), findsOneWidget);
    expect(find.text(AppStrings.allCoursesSubtitle), findsOneWidget);
    expect(find.text(AppStrings.subjectAll), findsOneWidget);
    expect(find.text(AppStrings.subjectScience), findsAtLeastNWidgets(1));
    expect(find.text(AppStrings.subjectMath), findsAtLeastNWidgets(1));
    expect(find.text(AppStrings.subjectArts), findsAtLeastNWidgets(1));

    // 2. Initial Category "All" renders top popular cards
    expect(find.text('Amazing Animals'), findsOneWidget);
    expect(find.text('Space Exploration'), findsOneWidget);

    // 3. Heart favorite buttons are present and toggleable
    final heartButtons = find.byIcon(Icons.favorite_border_rounded);
    expect(heartButtons, findsWidgets);

    await tester.tap(heartButtons.first);
    await tester.pumpAndSettle();
    expect(find.byIcon(Icons.favorite_rounded), findsAtLeastNWidgets(1));

    // 4. Switch to Math category chip -> shows Math Fun with Numbers
    await tester.tap(find.text(AppStrings.subjectMath).first);
    await tester.pumpAndSettle();
    expect(find.text('Math Fun with Numbers'), findsOneWidget);

    // 5. Switch to Arts category chip -> shows Creative Drawing
    await tester.tap(find.text(AppStrings.subjectArts));
    await tester.pumpAndSettle();
    expect(find.text('Creative Drawing'), findsOneWidget);
  });
}
