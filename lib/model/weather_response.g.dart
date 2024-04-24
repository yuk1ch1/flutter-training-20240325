// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: type=lint

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherResponseImpl _$$WeatherResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherResponseImpl(
      weatherCondition:
          $enumDecode(_$WeatherConditionEnumMap, json['weather_condition']),
      maxTemperature: json['max_temperature'] as int,
      minTemperature: json['min_temperature'] as int,
    );

Map<String, dynamic> _$$WeatherResponseImplToJson(
        _$WeatherResponseImpl instance) =>
    <String, dynamic>{
      'weather_condition':
          _$WeatherConditionEnumMap[instance.weatherCondition]!,
      'max_temperature': instance.maxTemperature,
      'min_temperature': instance.minTemperature,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.sunny: 'sunny',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.rainy: 'rainy',
};
