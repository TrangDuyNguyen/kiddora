import 'dart:convert';
import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:kiddora/features/exploration/domain/models/game_result.dart';
import 'package:kiddora/features/exploration/domain/models/lesson_blueprint.dart';
import 'package:kiddora/features/exploration/domain/models/lesson_stage.dart';

void main() {
  group('LessonBlueprint & LessonStageConfig Tests', () {
    test('Can deserialize lesson_anim_01_exploration.json correctly', () {
      final file = File('assets/lessons/lesson_anim_01_exploration.json');
      expect(file.existsSync(), isTrue);

      final jsonStr = file.readAsStringSync();
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      final blueprint = LessonBlueprint.fromJson(jsonMap);

      expect(blueprint.lessonId, equals('lesson_anim_01'));
      expect(blueprint.courseId, equals('course_amazing_animals'));
      expect(blueprint.title, equals('Gấu Bắc Cực & Bạn Băng Tuyết'));
      expect(blueprint.archetype, equals('exploration'));
      expect(blueprint.targetAgeGroup, equals('7-10'));
      expect(blueprint.estimatedDurationMins, equals(8));
      expect(blueprint.stages.length, equals(5));

      // Stage 1 (Engage)
      final stage1 = blueprint.stages[0];
      expect(stage1.stepOrder, equals(1));
      expect(stage1.stage5e, equals('engage'));
      expect(stage1.type, equals('mascot_hook'));
      expect(stage1.config['mascot_id'], equals('lion'));

      // Stage 4 (Elaborate - Mini Game)
      final stage4 = blueprint.stages[3];
      expect(stage4.stepOrder, equals(4));
      expect(stage4.stage5e, equals('elaborate'));
      expect(stage4.type, equals('tactile_mini_game'));
      expect(stage4.config['mechanic'], equals('clay_drag_drop_sorter'));
      expect((stage4.config['baskets'] as List).length, equals(2));
      expect((stage4.config['items'] as List).length, equals(3));
    });

    test('Can deserialize lesson_math_01_arcade.json correctly', () {
      final file = File('assets/lessons/lesson_math_01_arcade.json');
      expect(file.existsSync(), isTrue);

      final jsonStr = file.readAsStringSync();
      final Map<String, dynamic> jsonMap = json.decode(jsonStr);
      final blueprint = LessonBlueprint.fromJson(jsonMap);

      expect(blueprint.lessonId, equals('lesson_math_01'));
      expect(blueprint.courseId, equals('course_math_fun'));
      expect(blueprint.archetype, equals('arcade'));
      expect(blueprint.stages.length, equals(5));

      // Stage 4 (Elaborate - Scale Balancer)
      final stage4 = blueprint.stages[3];
      expect(stage4.config['mechanic'], equals('clay_scale_balancer'));
      expect(stage4.config['correct_answer'], equals(4));

      // Stage 5 (Evaluate - Bubble Quick Quiz)
      final stage5 = blueprint.stages[4];
      expect(stage5.type, equals('bubble_quick_quiz'));
      expect(stage5.config['star_reward'], equals(10));
      expect((stage5.config['bubbles'] as List).length, equals(3));
    });

    test('LessonBlueprint copyWith & toJson integrity', () {
      const stage = LessonStageConfig(
        stepOrder: 1,
        stage5e: 'engage',
        type: 'test_type',
        config: {'key': 'val'},
      );

      const blueprint = LessonBlueprint(
        lessonId: 'test_01',
        courseId: 'course_01',
        title: 'Test Title',
        stages: [stage],
      );

      final modified = blueprint.copyWith(title: 'Updated Title');
      expect(modified.title, equals('Updated Title'));
      expect(modified.lessonId, equals('test_01'));
      expect(modified.stages.first.config['key'], equals('val'));

      final jsonMap = modified.toJson();
      expect(jsonMap['lesson_id'], equals('test_01'));
      expect(jsonMap['title'], equals('Updated Title'));
      expect((jsonMap['stages'] as List).length, equals(1));
    });
  });

  group('GameResult Tests', () {
    test('GameResult default values and custom values', () {
      const defaultResult = GameResult(lessonId: 'lesson_test');
      expect(defaultResult.isCompleted, isFalse);
      expect(defaultResult.starsEarned, equals(0));
      expect(defaultResult.attemptsCount, equals(1));
      expect(defaultResult.hintsUsed, equals(0));
      expect(defaultResult.durationSeconds, equals(0));
      expect(defaultResult.completedAt, isNull);

      final now = DateTime(2026, 11, 3, 12, 0, 0);
      final completedResult = defaultResult.copyWith(
        isCompleted: true,
        starsEarned: 10,
        attemptsCount: 2,
        hintsUsed: 1,
        durationSeconds: 180,
        completedAt: now,
      );

      expect(completedResult.isCompleted, isTrue);
      expect(completedResult.starsEarned, equals(10));
      expect(completedResult.hintsUsed, equals(1));
      expect(completedResult.completedAt, equals(now));

      final jsonMap = completedResult.toJson();
      expect(jsonMap['lesson_id'], equals('lesson_test'));
      expect(jsonMap['is_completed'], isTrue);
      expect(jsonMap['stars_earned'], equals(10));

      final fromJson = GameResult.fromJson(jsonMap);
      expect(fromJson.lessonId, equals(completedResult.lessonId));
      expect(fromJson.isCompleted, equals(completedResult.isCompleted));
      expect(fromJson.starsEarned, equals(completedResult.starsEarned));
    });
  });
}

