// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_blueprint.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LessonBlueprint {
  @JsonKey(name: 'lesson_id')
  String get lessonId;
  @JsonKey(name: 'course_id')
  String get courseId;
  String get title;
  String get archetype;
  @JsonKey(name: 'target_age_group')
  String get targetAgeGroup;
  @JsonKey(name: 'estimated_duration_mins')
  int get estimatedDurationMins;
  List<LessonStageConfig> get stages;

  /// Create a copy of LessonBlueprint
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LessonBlueprintCopyWith<LessonBlueprint> get copyWith =>
      _$LessonBlueprintCopyWithImpl<LessonBlueprint>(
          this as LessonBlueprint, _$identity);

  /// Serializes this LessonBlueprint to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LessonBlueprint &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            (identical(other.targetAgeGroup, targetAgeGroup) ||
                other.targetAgeGroup == targetAgeGroup) &&
            (identical(other.estimatedDurationMins, estimatedDurationMins) ||
                other.estimatedDurationMins == estimatedDurationMins) &&
            const DeepCollectionEquality().equals(other.stages, stages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      lessonId,
      courseId,
      title,
      archetype,
      targetAgeGroup,
      estimatedDurationMins,
      const DeepCollectionEquality().hash(stages));

  @override
  String toString() {
    return 'LessonBlueprint(lessonId: $lessonId, courseId: $courseId, title: $title, archetype: $archetype, targetAgeGroup: $targetAgeGroup, estimatedDurationMins: $estimatedDurationMins, stages: $stages)';
  }
}

/// @nodoc
abstract mixin class $LessonBlueprintCopyWith<$Res> {
  factory $LessonBlueprintCopyWith(
          LessonBlueprint value, $Res Function(LessonBlueprint) _then) =
      _$LessonBlueprintCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'lesson_id') String lessonId,
      @JsonKey(name: 'course_id') String courseId,
      String title,
      String archetype,
      @JsonKey(name: 'target_age_group') String targetAgeGroup,
      @JsonKey(name: 'estimated_duration_mins') int estimatedDurationMins,
      List<LessonStageConfig> stages});
}

/// @nodoc
class _$LessonBlueprintCopyWithImpl<$Res>
    implements $LessonBlueprintCopyWith<$Res> {
  _$LessonBlueprintCopyWithImpl(this._self, this._then);

  final LessonBlueprint _self;
  final $Res Function(LessonBlueprint) _then;

  /// Create a copy of LessonBlueprint
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? lessonId = null,
    Object? courseId = null,
    Object? title = null,
    Object? archetype = null,
    Object? targetAgeGroup = null,
    Object? estimatedDurationMins = null,
    Object? stages = null,
  }) {
    return _then(_self.copyWith(
      lessonId: null == lessonId
          ? _self.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _self.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      archetype: null == archetype
          ? _self.archetype
          : archetype // ignore: cast_nullable_to_non_nullable
              as String,
      targetAgeGroup: null == targetAgeGroup
          ? _self.targetAgeGroup
          : targetAgeGroup // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedDurationMins: null == estimatedDurationMins
          ? _self.estimatedDurationMins
          : estimatedDurationMins // ignore: cast_nullable_to_non_nullable
              as int,
      stages: null == stages
          ? _self.stages
          : stages // ignore: cast_nullable_to_non_nullable
              as List<LessonStageConfig>,
    ));
  }
}

/// Adds pattern-matching-related methods to [LessonBlueprint].
extension LessonBlueprintPatterns on LessonBlueprint {
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
    TResult Function(_LessonBlueprint value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LessonBlueprint() when $default != null:
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
    TResult Function(_LessonBlueprint value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LessonBlueprint():
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
    TResult? Function(_LessonBlueprint value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LessonBlueprint() when $default != null:
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
            @JsonKey(name: 'course_id') String courseId,
            String title,
            String archetype,
            @JsonKey(name: 'target_age_group') String targetAgeGroup,
            @JsonKey(name: 'estimated_duration_mins') int estimatedDurationMins,
            List<LessonStageConfig> stages)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LessonBlueprint() when $default != null:
        return $default(
            _that.lessonId,
            _that.courseId,
            _that.title,
            _that.archetype,
            _that.targetAgeGroup,
            _that.estimatedDurationMins,
            _that.stages);
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
            @JsonKey(name: 'course_id') String courseId,
            String title,
            String archetype,
            @JsonKey(name: 'target_age_group') String targetAgeGroup,
            @JsonKey(name: 'estimated_duration_mins') int estimatedDurationMins,
            List<LessonStageConfig> stages)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LessonBlueprint():
        return $default(
            _that.lessonId,
            _that.courseId,
            _that.title,
            _that.archetype,
            _that.targetAgeGroup,
            _that.estimatedDurationMins,
            _that.stages);
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
            @JsonKey(name: 'course_id') String courseId,
            String title,
            String archetype,
            @JsonKey(name: 'target_age_group') String targetAgeGroup,
            @JsonKey(name: 'estimated_duration_mins') int estimatedDurationMins,
            List<LessonStageConfig> stages)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LessonBlueprint() when $default != null:
        return $default(
            _that.lessonId,
            _that.courseId,
            _that.title,
            _that.archetype,
            _that.targetAgeGroup,
            _that.estimatedDurationMins,
            _that.stages);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LessonBlueprint implements LessonBlueprint {
  const _LessonBlueprint(
      {@JsonKey(name: 'lesson_id') required this.lessonId,
      @JsonKey(name: 'course_id') required this.courseId,
      required this.title,
      this.archetype = 'exploration',
      @JsonKey(name: 'target_age_group') this.targetAgeGroup = '7-10',
      @JsonKey(name: 'estimated_duration_mins') this.estimatedDurationMins = 8,
      final List<LessonStageConfig> stages = const []})
      : _stages = stages;
  factory _LessonBlueprint.fromJson(Map<String, dynamic> json) =>
      _$LessonBlueprintFromJson(json);

  @override
  @JsonKey(name: 'lesson_id')
  final String lessonId;
  @override
  @JsonKey(name: 'course_id')
  final String courseId;
  @override
  final String title;
  @override
  @JsonKey()
  final String archetype;
  @override
  @JsonKey(name: 'target_age_group')
  final String targetAgeGroup;
  @override
  @JsonKey(name: 'estimated_duration_mins')
  final int estimatedDurationMins;
  final List<LessonStageConfig> _stages;
  @override
  @JsonKey()
  List<LessonStageConfig> get stages {
    if (_stages is EqualUnmodifiableListView) return _stages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_stages);
  }

  /// Create a copy of LessonBlueprint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LessonBlueprintCopyWith<_LessonBlueprint> get copyWith =>
      __$LessonBlueprintCopyWithImpl<_LessonBlueprint>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LessonBlueprintToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LessonBlueprint &&
            (identical(other.lessonId, lessonId) ||
                other.lessonId == lessonId) &&
            (identical(other.courseId, courseId) ||
                other.courseId == courseId) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.archetype, archetype) ||
                other.archetype == archetype) &&
            (identical(other.targetAgeGroup, targetAgeGroup) ||
                other.targetAgeGroup == targetAgeGroup) &&
            (identical(other.estimatedDurationMins, estimatedDurationMins) ||
                other.estimatedDurationMins == estimatedDurationMins) &&
            const DeepCollectionEquality().equals(other._stages, _stages));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      lessonId,
      courseId,
      title,
      archetype,
      targetAgeGroup,
      estimatedDurationMins,
      const DeepCollectionEquality().hash(_stages));

  @override
  String toString() {
    return 'LessonBlueprint(lessonId: $lessonId, courseId: $courseId, title: $title, archetype: $archetype, targetAgeGroup: $targetAgeGroup, estimatedDurationMins: $estimatedDurationMins, stages: $stages)';
  }
}

/// @nodoc
abstract mixin class _$LessonBlueprintCopyWith<$Res>
    implements $LessonBlueprintCopyWith<$Res> {
  factory _$LessonBlueprintCopyWith(
          _LessonBlueprint value, $Res Function(_LessonBlueprint) _then) =
      __$LessonBlueprintCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'lesson_id') String lessonId,
      @JsonKey(name: 'course_id') String courseId,
      String title,
      String archetype,
      @JsonKey(name: 'target_age_group') String targetAgeGroup,
      @JsonKey(name: 'estimated_duration_mins') int estimatedDurationMins,
      List<LessonStageConfig> stages});
}

/// @nodoc
class __$LessonBlueprintCopyWithImpl<$Res>
    implements _$LessonBlueprintCopyWith<$Res> {
  __$LessonBlueprintCopyWithImpl(this._self, this._then);

  final _LessonBlueprint _self;
  final $Res Function(_LessonBlueprint) _then;

  /// Create a copy of LessonBlueprint
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? lessonId = null,
    Object? courseId = null,
    Object? title = null,
    Object? archetype = null,
    Object? targetAgeGroup = null,
    Object? estimatedDurationMins = null,
    Object? stages = null,
  }) {
    return _then(_LessonBlueprint(
      lessonId: null == lessonId
          ? _self.lessonId
          : lessonId // ignore: cast_nullable_to_non_nullable
              as String,
      courseId: null == courseId
          ? _self.courseId
          : courseId // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _self.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      archetype: null == archetype
          ? _self.archetype
          : archetype // ignore: cast_nullable_to_non_nullable
              as String,
      targetAgeGroup: null == targetAgeGroup
          ? _self.targetAgeGroup
          : targetAgeGroup // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedDurationMins: null == estimatedDurationMins
          ? _self.estimatedDurationMins
          : estimatedDurationMins // ignore: cast_nullable_to_non_nullable
              as int,
      stages: null == stages
          ? _self._stages
          : stages // ignore: cast_nullable_to_non_nullable
              as List<LessonStageConfig>,
    ));
  }
}

// dart format on
