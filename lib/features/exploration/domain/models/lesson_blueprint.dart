import 'package:freezed_annotation/freezed_annotation.dart';
import 'lesson_stage.dart';

part 'lesson_blueprint.freezed.dart';
part 'lesson_blueprint.g.dart';

/// Complete JSON DSL blueprint for an interactive 5E lesson
@freezed
abstract class LessonBlueprint with _$LessonBlueprint {
  const factory LessonBlueprint({
    @JsonKey(name: 'lesson_id') required String lessonId,
    @JsonKey(name: 'course_id') required String courseId,
    required String title,
    @Default('exploration') String archetype,
    @JsonKey(name: 'target_age_group') @Default('7-10') String targetAgeGroup,
    @JsonKey(name: 'estimated_duration_mins') @Default(8) int estimatedDurationMins,
    @Default([]) List<LessonStageConfig> stages,
  }) = _LessonBlueprint;

  factory LessonBlueprint.fromJson(Map<String, dynamic> json) =>
      _$LessonBlueprintFromJson(json);
}

