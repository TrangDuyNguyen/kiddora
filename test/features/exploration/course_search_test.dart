import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/core/constants/app_strings.dart';
import 'package:kiddora/features/exploration/data/datasources/mock_course_datasource.dart';
import 'package:kiddora/features/exploration/data/repositories/course_repository_impl.dart';
import 'package:kiddora/features/exploration/presentation/course_search_screen.dart';

void main() {
  testWidgets('CourseSearchScreen searches courses and handles empty results',
      (tester) async {
    final mockRepo = MockCourseRepository(MockCourseDatasource.getBenchmarkCourses());

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          courseRepositoryProvider.overrideWithValue(mockRepo),
        ],
        child: const MaterialApp(
          home: CourseSearchScreen(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 1. Initial render
    expect(find.text(AppStrings.searchCoursesTitle), findsWidgets);
    expect(find.text(AppStrings.searchCoursesSubtitle), findsOneWidget);
    expect(find.textContaining(AppStrings.searchResultsTitle), findsOneWidget);

    // Initial results show all 6 courses
    expect(find.text('Amazing Animals'), findsOneWidget);
    expect(find.text('Space Exploration'), findsOneWidget);

    // 2. Search for "Space"
    final searchInput = find.byType(TextField);
    await tester.enterText(searchInput, 'Space');
    // Fast forward debounce timer (300ms)
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    expect(find.text('Space Exploration'), findsOneWidget);
    expect(find.text('Amazing Animals'), findsNothing);

    // 3. Search for nonexistent term -> Empty state
    await tester.enterText(searchInput, 'XYZNonExistentCourse');
    await tester.pump(const Duration(milliseconds: 350));
    await tester.pumpAndSettle();

    expect(find.text(AppStrings.noCoursesFoundTitle), findsOneWidget);
    expect(find.text(AppStrings.noCoursesFoundSubtitle), findsOneWidget);

    // 4. Tap Clear icon
    final clearBtn = find.byIcon(Icons.close_rounded);
    expect(clearBtn, findsOneWidget);
    await tester.tap(clearBtn);
    await tester.pumpAndSettle();

    // Cleared -> results reappear
    expect(find.text('Amazing Animals'), findsOneWidget);
  });
}

