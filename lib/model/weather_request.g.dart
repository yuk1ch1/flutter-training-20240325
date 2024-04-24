// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'weather_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WeatherRequestImpl _$$WeatherRequestImplFromJson(Map<String, dynamic> json) =>
    _$WeatherRequestImpl(
      area: json['area'] as String,
      date: DateTime.parse(json['date'] as String),
    );

Map<String, dynamic> _$$WeatherRequestImplToJson(
        _$WeatherRequestImpl instance) =>
    <String, dynamic>{
      'area': instance.area,
      'date': instance.date.toIso8601String(),
    };
