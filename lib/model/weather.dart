import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class Weather {
  const Weather({required YumemiWeather client}) : _client = client;
  final YumemiWeather _client;

  WeatherCondition? fetch() {
    final response = _client.fetchSimpleWeather();
    try {
      return WeatherCondition.from(response);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return null;
    }
  }
}
