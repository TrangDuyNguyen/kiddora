// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_blueprint.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessonBlueprint _$LessonBlueprintFromJson(Map<String, dynamic> json) =>
    _LessonBlueprint(
      lessonId: json['lesson_id'] as String,
      courseId: json['course_id'] as String,
      title: json['title'] as String,
      archetype: json['archetype'] as String? ?? 'exploration',
      targetAgeGroup: json['target_age_group'] as String? ?? '7-10',
      estimatedDurationMins:
          (json['estimated_duration_mins'] as num?)?.toInt() ?? 8,
      stages: (json['stages'] as List<dynamic>?)
              ?.map(
                  (e) => LessonStageConfig.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$LessonBlueprintToJson(_LessonBlueprint instance) =>
    <String, dynamic>{
      'lesson_id': instance.lessonId,
      'course_id': instance.courseId,
      'title': instance.title,
      'archetype': instance.archetype,
      'target_age_group': instance.targetAgeGroup,
      'estimated_duration_mins': instance.estimatedDurationMins,
      'stages': instance.stages,
    };
