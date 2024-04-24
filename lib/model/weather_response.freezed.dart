// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'weather_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) {
  return _WeatherResponse.fromJson(json);
}

/// @nodoc
mixin _$WeatherResponse {
  @JsonKey(name: 'weather_condition')
  WeatherCondition get weatherCondition => throw _privateConstructorUsedError;
  @JsonKey(name: 'max_temperature')
  int get maxTemperature => throw _privateConstructorUsedError;
  @JsonKey(name: 'min_temperature')
  int get minTemperature => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WeatherResponseCopyWith<WeatherResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WeatherResponseCopyWith<$Res> {
  factory $WeatherResponseCopyWith(
          WeatherResponse value, $Res Function(WeatherResponse) then) =
      _$WeatherResponseCopyWithImpl<$Res, WeatherResponse>;
  @useResult
  $Res call(
      {@JsonKey(name: 'weather_condition') WeatherCondition weatherCondition,
      @JsonKey(name: 'max_temperature') int maxTemperature,
      @JsonKey(name: 'min_temperature') int minTemperature});
}

/// @nodoc
class _$WeatherResponseCopyWithImpl<$Res, $Val extends WeatherResponse>
    implements $WeatherResponseCopyWith<$Res> {
  _$WeatherResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherCondition = null,
    Object? maxTemperature = null,
    Object? minTemperature = null,
  }) {
    return _then(_value.copyWith(
      weatherCondition: null == weatherCondition
          ? _value.weatherCondition
          : weatherCondition // ignore: cast_nullable_to_non_nullable
              as WeatherCondition,
      maxTemperature: null == maxTemperature
          ? _value.maxTemperature
          : maxTemperature // ignore: cast_nullable_to_non_nullable
              as int,
      minTemperature: null == minTemperature
          ? _value.minTemperature
          : minTemperature // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$WeatherResponseImplCopyWith<$Res>
    implements $WeatherResponseCopyWith<$Res> {
  factory _$$WeatherResponseImplCopyWith(_$WeatherResponseImpl value,
          $Res Function(_$WeatherResponseImpl) then) =
      __$$WeatherResponseImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'weather_condition') WeatherCondition weatherCondition,
      @JsonKey(name: 'max_temperature') int maxTemperature,
      @JsonKey(name: 'min_temperature') int minTemperature});
}

/// @nodoc
class __$$WeatherResponseImplCopyWithImpl<$Res>
    extends _$WeatherResponseCopyWithImpl<$Res, _$WeatherResponseImpl>
    implements _$$WeatherResponseImplCopyWith<$Res> {
  __$$WeatherResponseImplCopyWithImpl(
      _$WeatherResponseImpl _value, $Res Function(_$WeatherResponseImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? weatherCondition = null,
    Object? maxTemperature = null,
    Object? minTemperature = null,
  }) {
    return _then(_$WeatherResponseImpl(
      weatherCondition: null == weatherCondition
          ? _value.weatherCondition
          : weatherCondition // ignore: cast_nullable_to_non_nullable
              as WeatherCondition,
      maxTemperature: null == maxTemperature
          ? _value.maxTemperature
          : maxTemperature // ignore: cast_nullable_to_non_nullable
              as int,
      minTemperature: null == minTemperature
          ? _value.minTemperature
          : minTemperature // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$WeatherResponseImpl implements _WeatherResponse {
  const _$WeatherResponseImpl(
      {@JsonKey(name: 'weather_condition') required this.weatherCondition,
      @JsonKey(name: 'max_temperature') required this.maxTemperature,
      @JsonKey(name: 'min_temperature') required this.minTemperature});

  factory _$WeatherResponseImpl.fromJson(Map<String, dynamic> json) =>
      _$$WeatherResponseImplFromJson(json);

  @override
  @JsonKey(name: 'weather_condition')
  final WeatherCondition weatherCondition;
  @override
  @JsonKey(name: 'max_temperature')
  final int maxTemperature;
  @override
  @JsonKey(name: 'min_temperature')
  final int minTemperature;

  @override
  String toString() {
    return 'WeatherResponse(weatherCondition: $weatherCondition, maxTemperature: $maxTemperature, minTemperature: $minTemperature)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WeatherResponseImpl &&
            (identical(other.weatherCondition, weatherCondition) ||
                other.weatherCondition == weatherCondition) &&
            (identical(other.maxTemperature, maxTemperature) ||
                other.maxTemperature == maxTemperature) &&
            (identical(other.minTemperature, minTemperature) ||
                other.minTemperature == minTemperature));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, weatherCondition, maxTemperature, minTemperature);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$WeatherResponseImplCopyWith<_$WeatherResponseImpl> get copyWith =>
      __$$WeatherResponseImplCopyWithImpl<_$WeatherResponseImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WeatherResponseImplToJson(
      this,
    );
  }
}

abstract class _WeatherResponse implements WeatherResponse {
  const factory _WeatherResponse(
      {@JsonKey(name: 'weather_condition')
      required final WeatherCondition weatherCondition,
      @JsonKey(name: 'max_temperature') required final int maxTemperature,
      @JsonKey(name: 'min_temperature')
      required final int minTemperature}) = _$WeatherResponseImpl;

  factory _WeatherResponse.fromJson(Map<String, dynamic> json) =
      _$WeatherResponseImpl.fromJson;

  @override
  @JsonKey(name: 'weather_condition')
  WeatherCondition get weatherCondition;
  @override
  @JsonKey(name: 'max_temperature')
  int get maxTemperature;
  @override
  @JsonKey(name: 'min_temperature')
  int get minTemperature;
  @override
  @JsonKey(ignore: true)
  _$$WeatherResponseImplCopyWith<_$WeatherResponseImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
