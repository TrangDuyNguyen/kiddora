// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GameResult _$GameResultFromJson(Map<String, dynamic> json) => _GameResult(
      lessonId: json['lesson_id'] as String,
      isCompleted: json['is_completed'] as bool? ?? false,
      starsEarned: (json['stars_earned'] as num?)?.toInt() ?? 0,
      attemptsCount: (json['attempts_count'] as num?)?.toInt() ?? 1,
      hintsUsed: (json['hints_used'] as num?)?.toInt() ?? 0,
      durationSeconds: (json['duration_seconds'] as num?)?.toInt() ?? 0,
      completedAt: json['completed_at'] == null
          ? null
          : DateTime.parse(json['completed_at'] as String),
    );

Map<String, dynamic> _$GameResultToJson(_GameResult instance) =>
    <String, dynamic>{
      'lesson_id': instance.lessonId,
      'is_completed': instance.isCompleted,
      'stars_earned': instance.starsEarned,
      'attempts_count': instance.attemptsCount,
      'hints_used': instance.hintsUsed,
      'duration_seconds': instance.durationSeconds,
      'completed_at': instance.completedAt?.toIso8601String(),
    };
