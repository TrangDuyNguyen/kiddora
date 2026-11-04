// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GameResult {
  @JsonKey(name: 'lesson_id')
  String get lessonId;
  @JsonKey(name: 'is_completed')
  bool get isCompleted;
  @JsonKey(name: 'stars_earned')
  int get starsEarned;
  @JsonKey(name: 'attempts_count')
  int get attemptsCount;
  @JsonKey(name: 'hints_used')
  int get hintsUsed;
  @JsonKey(name: 'duration_seconds')
  int get durationSeconds;
  @JsonKey(name: 'completed_at')
  DateTime? get completedAt;

  /// Create a copy of GameResult
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $GameResultCopyWith<GameResult> get copyWith =>
      _$GameResultCopyWithImpl<GameResult>(this as GameResult, _$identity);

  /// Serializes this GameResult to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is GameResult &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.starsEarned, starsEarned) ||
                other.starsEarned == starsEarned) &&
            (identical(other.attemptsCount, attemptsCount) ||
                other.attemptsCount == attemptsCount) &&
            (identical(other.hintsUsed, hintsUsed) ||
                other.hintsUsed == hintsUsed) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lessonId, isCompleted,
      starsEarned, attemptsCount, hintsUsed, durationSeconds, completedAt);

  @override
  String toString() {
    return 'GameResult(lessonId: $lessonId, isCompleted: $isCompleted, starsEarned: $starsEarned, attemptsCount: $attemptsCount, hintsUsed: $hintsUsed, durationSeconds: $durationSeconds, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class $GameResultCopyWith<$Res> {
  factory $GameResultCopyWith(
          GameResult value, $Res Function(GameResult) _then) =
      _$GameResultCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'lesson_id') String lessonId,
      @JsonKey(name: 'is_completed') bool isCompleted,
      @JsonKey(name: 'stars_earned') int starsEarned,
      @JsonKey(name: 'attempts_count') int attemptsCount,
      @JsonKey(name: 'hints_used') int hintsUsed,
      @JsonKey(name: 'duration_seconds') int durationSeconds,
      @JsonKey(name: 'completed_at') DateTime? completedAt});
}

/// @nodoc
class _$GameResultCopyWithImpl<$Res> implements $GameResultCopyWith<$Res> {
  _$GameResultCopyWithImpl(this._self, this._then);

  final GameResult _self;
  final $Res Function(GameResult) _then;

  /// Create a copy of GameResult
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
    Object? isCompleted = null,
    Object? starsEarned = null,
    Object? attemptsCount = null,
    Object? hintsUsed = null,
    Object? durationSeconds = null,
    Object? completedAt = freezed,
  }) {
    return _then(_self.copyWith(
      lessonId: null == lessonId
          ? _self.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      starsEarned: null == starsEarned
          ? _self.starsEarned
          : starsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      attemptsCount: null == attemptsCount
          ? _self.attemptsCount
          : attemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      hintsUsed: null == hintsUsed
          ? _self.hintsUsed
          : hintsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: null == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// Adds pattern-matching-related methods to [GameResult].
extension GameResultPatterns on GameResult {
  /// A variant of `map` that fallback to returning `orElse`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(_GameResult value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GameResult() when $default != null:
        return $default(_that);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// Callbacks receives the raw object, upcasted.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case final Subclass2 value:
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(_GameResult value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GameResult():
        return $default(_that);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `map` that fallback to returning `null`.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case final Subclass value:
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(_GameResult value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GameResult() when $default != null:
        return $default(_that);
      case _:
        return null;
    }
  }

  /// A variant of `when` that fallback to an `orElse` callback.
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return orElse();
  /// }
  /// ```

  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'lesson_id') String lessonId,
            @JsonKey(name: 'is_completed') bool isCompleted,
            @JsonKey(name: 'stars_earned') int starsEarned,
            @JsonKey(name: 'attempts_count') int attemptsCount,
            @JsonKey(name: 'hints_used') int hintsUsed,
            @JsonKey(name: 'duration_seconds') int durationSeconds,
            @JsonKey(name: 'completed_at') DateTime? completedAt)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _GameResult() when $default != null:
        return $default(
            _that.lessonId,
            _that.isCompleted,
            _that.starsEarned,
            _that.attemptsCount,
            _that.hintsUsed,
            _that.durationSeconds,
            _that.completedAt);
      case _:
        return orElse();
    }
  }

  /// A `switch`-like method, using callbacks.
  ///
  /// As opposed to `map`, this offers destructuring.
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case Subclass2(:final field2):
  ///     return ...;
  /// }
  /// ```

  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(
            @JsonKey(name: 'lesson_id') String lessonId,
            @JsonKey(name: 'is_completed') bool isCompleted,
            @JsonKey(name: 'stars_earned') int starsEarned,
            @JsonKey(name: 'attempts_count') int attemptsCount,
            @JsonKey(name: 'hints_used') int hintsUsed,
            @JsonKey(name: 'duration_seconds') int durationSeconds,
            @JsonKey(name: 'completed_at') DateTime? completedAt)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GameResult():
        return $default(
            _that.lessonId,
            _that.isCompleted,
            _that.starsEarned,
            _that.attemptsCount,
            _that.hintsUsed,
            _that.durationSeconds,
            _that.completedAt);
      case _:
        throw StateError('Unexpected subclass');
    }
  }

  /// A variant of `when` that fallback to returning `null`
  ///
  /// It is equivalent to doing:
  /// ```dart
  /// switch (sealedClass) {
  ///   case Subclass(:final field):
  ///     return ...;
  ///   case _:
  ///     return null;
  /// }
  /// ```

  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(
            @JsonKey(name: 'lesson_id') String lessonId,
            @JsonKey(name: 'is_completed') bool isCompleted,
            @JsonKey(name: 'stars_earned') int starsEarned,
            @JsonKey(name: 'attempts_count') int attemptsCount,
            @JsonKey(name: 'hints_used') int hintsUsed,
            @JsonKey(name: 'duration_seconds') int durationSeconds,
            @JsonKey(name: 'completed_at') DateTime? completedAt)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _GameResult() when $default != null:
        return $default(
            _that.lessonId,
            _that.isCompleted,
            _that.starsEarned,
            _that.attemptsCount,
            _that.hintsUsed,
            _that.durationSeconds,
            _that.completedAt);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _GameResult implements GameResult {
  const _GameResult(
      {@JsonKey(name: 'lesson_id') required this.lessonId,
      @JsonKey(name: 'is_completed') this.isCompleted = false,
      @JsonKey(name: 'stars_earned') this.starsEarned = 0,
      @JsonKey(name: 'attempts_count') this.attemptsCount = 1,
      @JsonKey(name: 'hints_used') this.hintsUsed = 0,
      @JsonKey(name: 'duration_seconds') this.durationSeconds = 0,
      @JsonKey(name: 'completed_at') this.completedAt});
  factory _GameResult.fromJson(Map<String, dynamic> json) =>
      _$GameResultFromJson(json);

  @override
  @JsonKey(name: 'lesson_id')
  final String lessonId;
  @override
  @JsonKey(name: 'is_completed')
  final bool isCompleted;
  @override
  @JsonKey(name: 'stars_earned')
  final int starsEarned;
  @override
  @JsonKey(name: 'attempts_count')
  final int attemptsCount;
  @override
  @JsonKey(name: 'hints_used')
  final int hintsUsed;
  @override
  @JsonKey(name: 'duration_seconds')
  final int durationSeconds;
  @override
  @JsonKey(name: 'completed_at')
  final DateTime? completedAt;

  /// Create a copy of GameResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$GameResultCopyWith<_GameResult> get copyWith =>
      __$GameResultCopyWithImpl<_GameResult>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$GameResultToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _GameResult &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.isCompleted, isCompleted) ||
                other.isCompleted == isCompleted) &&
            (identical(other.starsEarned, starsEarned) ||
                other.starsEarned == starsEarned) &&
            (identical(other.attemptsCount, attemptsCount) ||
                other.attemptsCount == attemptsCount) &&
            (identical(other.hintsUsed, hintsUsed) ||
                other.hintsUsed == hintsUsed) &&
            (identical(other.durationSeconds, durationSeconds) ||
                other.durationSeconds == durationSeconds) &&
            (identical(other.completedAt, completedAt) ||
                other.completedAt == completedAt));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, lessonId, isCompleted,
      starsEarned, attemptsCount, hintsUsed, durationSeconds, completedAt);

  @override
  String toString() {
    return 'GameResult(lessonId: $lessonId, isCompleted: $isCompleted, starsEarned: $starsEarned, attemptsCount: $attemptsCount, hintsUsed: $hintsUsed, durationSeconds: $durationSeconds, completedAt: $completedAt)';
  }
}

/// @nodoc
abstract mixin class _$GameResultCopyWith<$Res>
    implements $GameResultCopyWith<$Res> {
  factory _$GameResultCopyWith(
          _GameResult value, $Res Function(_GameResult) _then) =
      __$GameResultCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'lesson_id') String lessonId,
      @JsonKey(name: 'is_completed') bool isCompleted,
      @JsonKey(name: 'stars_earned') int starsEarned,
      @JsonKey(name: 'attempts_count') int attemptsCount,
      @JsonKey(name: 'hints_used') int hintsUsed,
      @JsonKey(name: 'duration_seconds') int durationSeconds,
      @JsonKey(name: 'completed_at') DateTime? completedAt});
}

/// @nodoc
class __$GameResultCopyWithImpl<$Res> implements _$GameResultCopyWith<$Res> {
  __$GameResultCopyWithImpl(this._self, this._then);

  final _GameResult _self;
  final $Res Function(_GameResult) _then;

  /// Create a copy of GameResult
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lessonId = null,
    Object? isCompleted = null,
    Object? starsEarned = null,
    Object? attemptsCount = null,
    Object? hintsUsed = null,
    Object? durationSeconds = null,
    Object? completedAt = freezed,
  }) {
    return _then(_GameResult(
      lessonId: null == lessonId
          ? _self.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      isCompleted: null == isCompleted
          ? _self.isCompleted
          : isCompleted // ignore: cast_nullable_to_non_nullable
              as bool,
      starsEarned: null == starsEarned
          ? _self.starsEarned
          : starsEarned // ignore: cast_nullable_to_non_nullable
              as int,
      attemptsCount: null == attemptsCount
          ? _self.attemptsCount
          : attemptsCount // ignore: cast_nullable_to_non_nullable
              as int,
      hintsUsed: null == hintsUsed
          ? _self.hintsUsed
          : hintsUsed // ignore: cast_nullable_to_non_nullable
              as int,
      durationSeconds: null == durationSeconds
          ? _self.durationSeconds
          : durationSeconds // ignore: cast_nullable_to_non_nullable
              as int,
      completedAt: freezed == completedAt
          ? _self.completedAt
          : completedAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

// dart format on
