import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/features/exploration/data/datasources/lesson_datasource.dart';
import 'package:kiddora/features/exploration/domain/models/lesson_blueprint.dart';
import 'package:kiddora/features/exploration/domain/models/lesson_stage.dart';
import 'package:kiddora/features/exploration/presentation/controllers/lesson_player_controller.dart';
import 'package:kiddora/features/exploration/presentation/pages/lesson_player_screen.dart';
import 'package:kiddora/features/exploration/presentation/widgets/exit_confirmation_dialog.dart';
import 'package:kiddora/features/exploration/presentation/widgets/lesson_progress_dots.dart';

class FakeLessonDatasource implements ILessonDatasource {
  @override
  Future<LessonBlueprint> getLessonBlueprint(String lessonId) async {
    return const LessonBlueprint(
      lessonId: 'test_lesson_01',
      courseId: 'course_test',
      title: 'Amazing Animals 5E',
      archetype: 'exploration',
      stages: [
        LessonStageConfig(
          stepOrder: 1,
          stage5e: 'engage',
          type: 'mascot_hook',
          config: {
            'greeting_text': 'Chào bé! Bạn có biết loài gấu trắng ở đâu không?',
            'action_cta': 'Cùng đi tìm nào!',
          },
        ),
        LessonStageConfig(
          stepOrder: 2,
          stage5e: 'explore',
          type: 'interactive_explore',
          config: {
            'instruction': 'Khám phá thế giới băng giá',
          },
        ),
        LessonStageConfig(
          stepOrder: 3,
          stage5e: 'explain',
          type: 'concept_card_3d',
          config: {
            'title': 'Bộ Lông Dày',
            'key_takeaways': ['Giữ ấm cơ thể'],
          },
        ),
        LessonStageConfig(
          stepOrder: 4,
          stage5e: 'elaborate',
          type: 'tactile_mini_game',
          config: {
            'mechanic': 'clay_bubble_popper',
            'instruction': 'Bấm bóng có kết quả đúng',
          },
        ),
        LessonStageConfig(
          stepOrder: 5,
          stage5e: 'evaluate',
          type: 'celebration_summary',
          config: {
            'motivational_quote': 'Bé thật xuất sắc!',
          },
        ),
      ],
    );
  }
}

void main() {
  Widget buildTestableWidget({required String lessonId}) {
    return ProviderScope(
      overrides: [
        lessonDatasourceProvider.overrideWithValue(FakeLessonDatasource()),
      ],
      child: MaterialApp(
        home: LessonPlayerScreen(lessonId: lessonId),
      ),
    );
  }

  group('LessonPlayerScreen 5E Engine Tests', () {
    testWidgets('Loads blueprint and renders E1 Engage stage with progress dots',
        (tester) async {
      await tester.pumpWidget(buildTestableWidget(lessonId: 'test_lesson_01'));
      await tester.pumpAndSettle();

      // Progress dots exists
      expect(find.byType(LessonProgressDots), findsOneWidget);

      // E1 Engage Mascot dialogue exists
      expect(
        find.text('Chào bé! Bạn có biết loài gấu trắng ở đâu không?'),
        findsOneWidget,
      );
      expect(find.text('Cùng đi tìm nào!'), findsOneWidget);
    });

    testWidgets('Advances through 5E stages when tapping CTA', (tester) async {
      await tester.pumpWidget(buildTestableWidget(lessonId: 'test_lesson_01'));
      await tester.pumpAndSettle();

      // Advance from E1 to E2 (Explore)
      await tester.tap(find.text('Cùng đi tìm nào!'));
      await tester.pumpAndSettle();

      expect(find.text('Khám phá thế giới băng giá'), findsOneWidget);

      // Advance from E2 to E3 (Explain)
      await tester.tap(find.text('Tiếp tục'));
      await tester.pumpAndSettle();

      expect(find.text('Bộ Lông Dày'), findsOneWidget);
      expect(find.text('Giữ ấm cơ thể'), findsOneWidget);

      // Advance from E3 to E4 (Elaborate - Mini Game)
      await tester.tap(find.text('Vận dụng ngay!'));
      await tester.pump();
      await tester.pump(const Duration(milliseconds: 500));

      expect(find.text('Bấm bóng có kết quả đúng'), findsOneWidget);
    });

    testWidgets('Close button triggers ExitConfirmationDialog', (tester) async {
      await tester.pumpWidget(buildTestableWidget(lessonId: 'test_lesson_01'));
      await tester.pumpAndSettle();

      // Tap close button [X]
      await tester.tap(find.byIcon(Icons.close_rounded));
      await tester.pumpAndSettle();

      expect(find.byType(ExitConfirmationDialog), findsOneWidget);
      expect(find.text('Tạm dừng bài học?'), findsOneWidget);
      expect(find.text('Học tiếp'), findsOneWidget);
      expect(find.text('Lưu & Thoát'), findsOneWidget);

      // Tap "Học tiếp" dismisses dialog
      await tester.tap(find.text('Học tiếp'));
      await tester.pumpAndSettle();

      expect(find.byType(ExitConfirmationDialog), findsNothing);
    });
  });
}
