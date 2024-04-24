// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherResponseImpl _$$WeatherResponseImplFromJson(
        Map<String, dynamic> json) =>
    _$WeatherResponseImpl(
      weatherCondition:
          $enumDecode(_$WeatherConditionEnumMap, json['weatherCondition']),
      maxTemperature: json['maxTemperature'] as int,
      minTemperature: json['minTemperature'] as int,
    );

Map<String, dynamic> _$$WeatherResponseImplToJson(
        _$WeatherResponseImpl instance) =>
    <String, dynamic>{
      'weatherCondition': _$WeatherConditionEnumMap[instance.weatherCondition]!,
      'maxTemperature': instance.maxTemperature,
      'minTemperature': instance.minTemperature,
    };

const _$WeatherConditionEnumMap = {
  WeatherCondition.sunny: 'sunny',
  WeatherCondition.cloudy: 'cloudy',
  WeatherCondition.rainy: 'rainy',
};
