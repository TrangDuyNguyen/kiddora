import 'dart:convert';
import 'package:flutter/services.dart';
import '../../domain/models/lesson_blueprint.dart';
import '../../domain/models/lesson_stage.dart';

abstract class ILessonDatasource {
  Future<LessonBlueprint> getLessonBlueprint(String lessonId);
}

class LessonDatasourceImpl implements ILessonDatasource {
  const LessonDatasourceImpl();

  @override
  Future<LessonBlueprint> getLessonBlueprint(String lessonId) async {
    String assetPath;
    if (lessonId.contains('math') || lessonId == 'lesson_02') {
      assetPath = 'assets/lessons/lesson_math_01_arcade.json';
    } else {
      assetPath = 'assets/lessons/lesson_anim_01_exploration.json';
    }

    try {
      final jsonStr = await rootBundle.loadString(assetPath);
      final jsonMap = json.decode(jsonStr) as Map<String, dynamic>;
      return LessonBlueprint.fromJson(jsonMap);
    } catch (_) {
      // Fallback in case of missing asset in test environments
      return _generateFallbackBlueprint(lessonId);
    }
  }

  LessonBlueprint _generateFallbackBlueprint(String lessonId) {
    return LessonBlueprint(
      lessonId: lessonId,
      courseId: 'course_default',
      title: 'Khám Phá Bài Học 5E',
      archetype: 'exploration',
      stages: const [
        LessonStageConfig(
          stepOrder: 1,
          stage5e: 'engage',
          type: 'mascot_hook',
          config: {
            'mascot_id': 'lion',
            'greeting_text': 'Chào bé! Cùng nhau bước vào chuyến phiêu lưu mới nhé!',
            'action_cta': 'Bắt đầu nào!',
          },
        ),
        LessonStageConfig(
          stepOrder: 2,
          stage5e: 'explore',
          type: 'interactive_explore',
          config: {
            'instruction': 'Chạm vào các hình vẽ để khám phá bí mật nhé!',
          },
        ),
        LessonStageConfig(
          stepOrder: 3,
          stage5e: 'explain',
          type: 'concept_card_3d',
          config: {
            'title': 'Kiến Thức Trọng Tâm',
            'key_takeaways': [
              'Quan sát kỹ trước khi phán đoán',
              'Luôn đặt câu hỏi vì sao',
            ],
          },
        ),
        LessonStageConfig(
          stepOrder: 4,
          stage5e: 'elaborate',
          type: 'tactile_mini_game',
          config: {
            'mechanic': 'clay_bubble_popper',
          },
        ),
        LessonStageConfig(
          stepOrder: 5,
          stage5e: 'evaluate',
          type: 'celebration_summary',
          config: {
            'star_reward': 10,
            'motivational_quote': 'Bé đã học rất xuất sắc hôm nay!',
          },
        ),
      ],
    );
  }
}

