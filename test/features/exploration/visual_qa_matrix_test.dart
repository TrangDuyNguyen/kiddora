import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/features/exploration/data/datasources/mock_course_datasource.dart';
import 'package:kiddora/features/exploration/data/repositories/course_repository_impl.dart';
import 'package:kiddora/features/exploration/presentation/all_courses_grid_screen.dart';
import 'package:kiddora/features/exploration/presentation/course_curriculum_screen.dart';
import 'package:kiddora/features/exploration/presentation/course_detail_screen.dart';
import 'package:kiddora/features/exploration/presentation/course_filter_sheet.dart';
import 'package:kiddora/features/exploration/presentation/course_search_screen.dart';
import 'package:kiddora/features/exploration/presentation/courses_hub_body.dart';

void main() {
  const Size compactScreenSize = Size(360, 640);
  final mockRepo = MockCourseRepository(MockCourseDatasource.getBenchmarkCourses());

  Widget buildTestHost(Widget child) {
    return ProviderScope(
      overrides: [
        courseRepositoryProvider.overrideWithValue(mockRepo),
      ],
      child: MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(
            size: compactScreenSize,
            textScaler: TextScaler.linear(1.5),
          ),
          child: child,
        ),
      ),
    );
  }

  group('Visual QA Matrix — 0 RenderFlex Overflow on 360x640 with textScaler: 1.5x', () {
    testWidgets('1. CoursesHubBody layout integrity', (tester) async {
      tester.view.physicalSize = compactScreenSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildTestHost(const Scaffold(body: SafeArea(child: CoursesHubBody()))));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('2. CourseSearchScreen layout integrity', (tester) async {
      tester.view.physicalSize = compactScreenSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildTestHost(const CourseSearchScreen()));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('3. CourseFilterScreen layout integrity', (tester) async {
      tester.view.physicalSize = compactScreenSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildTestHost(const CourseFilterScreen()));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('4. AllCoursesGridScreen layout integrity', (tester) async {
      tester.view.physicalSize = compactScreenSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildTestHost(const AllCoursesGridScreen()));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('5. CourseDetailScreen layout integrity', (tester) async {
      tester.view.physicalSize = compactScreenSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildTestHost(const CourseDetailScreen(courseId: 'course_amazing_animals')));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });

    testWidgets('6. CourseCurriculumScreen layout integrity', (tester) async {
      tester.view.physicalSize = compactScreenSize;
      tester.view.devicePixelRatio = 1.0;
      addTearDown(tester.view.resetPhysicalSize);

      await tester.pumpWidget(buildTestHost(const CourseCurriculumScreen(courseId: 'course_amazing_animals')));
      await tester.pumpAndSettle();

      expect(tester.takeException(), isNull);
    });
  });
}
