// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WeatherRequest _$WeatherRequestFromJson(Map<String, dynamic> json) =>
    WeatherRequest(
      area: json['area'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$WeatherRequestToJson(WeatherRequest instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.date.toIso8601String(),
    };
