// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_stage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_LessonStageConfig _$LessonStageConfigFromJson(Map<String, dynamic> json) =>
    _LessonStageConfig(
      stepOrder: (json['step_order'] as num).toInt(),
      stage5e: json['stage_5e'] as String,
      type: json['type'] as String,
      config: json['config'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$LessonStageConfigToJson(_LessonStageConfig instance) =>
    <String, dynamic>{
      'step_order': instance.stepOrder,
      'stage_5e': instance.stage5e,
      'type': instance.type,
      'config': instance.config,
    };
