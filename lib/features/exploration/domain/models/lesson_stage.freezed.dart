// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'lesson_stage.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LessonStageConfig {
  @JsonKey(name: 'step_order')
  int get stepOrder;
  @JsonKey(name: 'stage_5e')
  String get stage5e;
  String get type;
  Map<String, dynamic> get config;

  /// Create a copy of LessonStageConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  $LessonStageConfigCopyWith<LessonStageConfig> get copyWith =>
      _$LessonStageConfigCopyWithImpl<LessonStageConfig>(
          this as LessonStageConfig, _$identity);

  /// Serializes this LessonStageConfig to a JSON map.
  Map<String, dynamic> toJson();

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is LessonStageConfig &&
            (identical(other.stepOrder, stepOrder) ||
                other.stepOrder == stepOrder) &&
            (identical(other.stage5e, stage5e) || other.stage5e == stage5e) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other.config, config));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stepOrder, stage5e, type,
      const DeepCollectionEquality().hash(config));

  @override
  String toString() {
    return 'LessonStageConfig(stepOrder: $stepOrder, stage5e: $stage5e, type: $type, config: $config)';
  }
}

/// @nodoc
abstract mixin class $LessonStageConfigCopyWith<$Res> {
  factory $LessonStageConfigCopyWith(
          LessonStageConfig value, $Res Function(LessonStageConfig) _then) =
      _$LessonStageConfigCopyWithImpl;
  @useResult
  $Res call(
      {@JsonKey(name: 'step_order') int stepOrder,
      @JsonKey(name: 'stage_5e') String stage5e,
      String type,
      Map<String, dynamic> config});
}

/// @nodoc
class _$LessonStageConfigCopyWithImpl<$Res>
    implements $LessonStageConfigCopyWith<$Res> {
  _$LessonStageConfigCopyWithImpl(this._self, this._then);

  final LessonStageConfig _self;
  final $Res Function(LessonStageConfig) _then;

  /// Create a copy of LessonStageConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? stepOrder = null,
    Object? stage5e = null,
    Object? type = null,
    Object? config = null,
  }) {
    return _then(_self.copyWith(
      stepOrder: null == stepOrder
          ? _self.stepOrder
          : stepOrder // ignore: cast_nullable_to_non_nullable
              as int,
      stage5e: null == stage5e
          ? _self.stage5e
          : stage5e // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _self.config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// Adds pattern-matching-related methods to [LessonStageConfig].
extension LessonStageConfigPatterns on LessonStageConfig {
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
    TResult Function(_LessonStageConfig value)? $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LessonStageConfig() when $default != null:
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
    TResult Function(_LessonStageConfig value) $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LessonStageConfig():
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
    TResult? Function(_LessonStageConfig value)? $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LessonStageConfig() when $default != null:
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
            @JsonKey(name: 'step_order') int stepOrder,
            @JsonKey(name: 'stage_5e') String stage5e,
            String type,
            Map<String, dynamic> config)?
        $default, {
    required TResult orElse(),
  }) {
    final _that = this;
    switch (_that) {
      case _LessonStageConfig() when $default != null:
        return $default(
            _that.stepOrder, _that.stage5e, _that.type, _that.config);
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
            @JsonKey(name: 'step_order') int stepOrder,
            @JsonKey(name: 'stage_5e') String stage5e,
            String type,
            Map<String, dynamic> config)
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LessonStageConfig():
        return $default(
            _that.stepOrder, _that.stage5e, _that.type, _that.config);
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
            @JsonKey(name: 'step_order') int stepOrder,
            @JsonKey(name: 'stage_5e') String stage5e,
            String type,
            Map<String, dynamic> config)?
        $default,
  ) {
    final _that = this;
    switch (_that) {
      case _LessonStageConfig() when $default != null:
        return $default(
            _that.stepOrder, _that.stage5e, _that.type, _that.config);
      case _:
        return null;
    }
  }
}

/// @nodoc
@JsonSerializable()
class _LessonStageConfig implements LessonStageConfig {
  const _LessonStageConfig(
      {@JsonKey(name: 'step_order') required this.stepOrder,
      @JsonKey(name: 'stage_5e') required this.stage5e,
      required this.type,
      final Map<String, dynamic> config = const {}})
      : _config = config;
  factory _LessonStageConfig.fromJson(Map<String, dynamic> json) =>
      _$LessonStageConfigFromJson(json);

  @override
  @JsonKey(name: 'step_order')
  final int stepOrder;
  @override
  @JsonKey(name: 'stage_5e')
  final String stage5e;
  @override
  final String type;
  final Map<String, dynamic> _config;
  @override
  @JsonKey()
  Map<String, dynamic> get config {
    if (_config is EqualUnmodifiableMapView) return _config;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_config);
  }

  /// Create a copy of LessonStageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  @pragma('vm:prefer-inline')
  _$LessonStageConfigCopyWith<_LessonStageConfig> get copyWith =>
      __$LessonStageConfigCopyWithImpl<_LessonStageConfig>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$LessonStageConfigToJson(
      this,
    );
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _LessonStageConfig &&
            (identical(other.stepOrder, stepOrder) ||
                other.stepOrder == stepOrder) &&
            (identical(other.stage5e, stage5e) || other.stage5e == stage5e) &&
            (identical(other.type, type) || other.type == type) &&
            const DeepCollectionEquality().equals(other._config, _config));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, stepOrder, stage5e, type,
      const DeepCollectionEquality().hash(_config));

  @override
  String toString() {
    return 'LessonStageConfig(stepOrder: $stepOrder, stage5e: $stage5e, type: $type, config: $config)';
  }
}

/// @nodoc
abstract mixin class _$LessonStageConfigCopyWith<$Res>
    implements $LessonStageConfigCopyWith<$Res> {
  factory _$LessonStageConfigCopyWith(
          _LessonStageConfig value, $Res Function(_LessonStageConfig) _then) =
      __$LessonStageConfigCopyWithImpl;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'step_order') int stepOrder,
      @JsonKey(name: 'stage_5e') String stage5e,
      String type,
      Map<String, dynamic> config});
}

/// @nodoc
class __$LessonStageConfigCopyWithImpl<$Res>
    implements _$LessonStageConfigCopyWith<$Res> {
  __$LessonStageConfigCopyWithImpl(this._self, this._then);

  final _LessonStageConfig _self;
  final $Res Function(_LessonStageConfig) _then;

  /// Create a copy of LessonStageConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $Res call({
    Object? stepOrder = null,
    Object? stage5e = null,
    Object? type = null,
    Object? config = null,
  }) {
    return _then(_LessonStageConfig(
      stepOrder: null == stepOrder
          ? _self.stepOrder
          : stepOrder // ignore: cast_nullable_to_non_nullable
              as int,
      stage5e: null == stage5e
          ? _self.stage5e
          : stage5e // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _self.type
          : type // ignore: cast_nullable_to_non_nullable
              as String,
      config: null == config
          ? _self._config
          : config // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

// dart format on
