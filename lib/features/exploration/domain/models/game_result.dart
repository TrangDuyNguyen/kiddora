import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_result.freezed.dart';
part 'game_result.g.dart';

/// Performance and completion metric for a tactile mini-game or 5E stage
@freezed
abstract class GameResult with _$GameResult {
  const factory GameResult({
    @JsonKey(name: 'lesson_id') required String lessonId,
    @JsonKey(name: 'is_completed') @Default(false) bool isCompleted,
    @JsonKey(name: 'stars_earned') @Default(0) int starsEarned,
    @JsonKey(name: 'attempts_count') @Default(1) int attemptsCount,
    @JsonKey(name: 'hints_used') @Default(0) int hintsUsed,
    @JsonKey(name: 'duration_seconds') @Default(0) int durationSeconds,
    @JsonKey(name: 'completed_at') DateTime? completedAt,
  }) = _GameResult;

  factory GameResult.fromJson(Map<String, dynamic> json) =>
      _$GameResultFromJson(json);
}

