import 'package:flutter_training/model/weather_condition.dart';

class WeatherResponse {
  const WeatherResponse({
    required this.weatherCondition,
    required this.maxTemperature,
    required this.minTemperature,
  });

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    return WeatherResponse(
      weatherCondition:
          WeatherCondition.from(json['weather_condition'] as String),
      maxTemperature: json['max_temperature'] as int,
      minTemperature: json['min_temperature'] as int,
    );
  }

  final WeatherCondition weatherCondition;
  final int maxTemperature;
  final int minTemperature;
}
