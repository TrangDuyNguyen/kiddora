import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_stage.freezed.dart';
part 'lesson_stage.g.dart';

/// Configuration for a single 5E pedagogy stage within a lesson
@freezed
abstract class LessonStageConfig with _$LessonStageConfig {
  const factory LessonStageConfig({
    @JsonKey(name: 'step_order') required int stepOrder,
    @JsonKey(name: 'stage_5e') required String stage5e,
    required String type,
    @Default({}) Map<String, dynamic> config,
  }) = _LessonStageConfig;

  factory LessonStageConfig.fromJson(Map<String, dynamic> json) =>
      _$LessonStageConfigFromJson(json);
}

