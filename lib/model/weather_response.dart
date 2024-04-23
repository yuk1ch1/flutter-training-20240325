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
          WeatherCondition.from(json['weather_condition'].toString()),
      maxTemperature: int.parse(json['max_temperature'].toString()),
      minTemperature: int.parse(json['min_temperature'].toString()),
    );
  }

  final WeatherCondition weatherCondition;
  final int maxTemperature;
  final int minTemperature;
}
