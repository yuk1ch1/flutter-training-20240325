// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherResponse _$WeatherResponseFromJson(Map<String, dynamic> json) =>
    WeatherResponse(
      weatherCondition:
          $enumDecode(_$WeatherConditionEnumMap, json['weatherCondition']),
      maxTemperature: json['maxTemperature'] as int,
      minTemperature: json['minTemperature'] as int,
    );

Map<String, dynamic> _$WeatherResponseToJson(WeatherResponse instance) =>
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
