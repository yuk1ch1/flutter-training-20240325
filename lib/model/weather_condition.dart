import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_exception.dart';

enum WeatherCondition {
  sunny,
  cloudy,
  rainy;

  factory WeatherCondition.from(String name) {
    return WeatherCondition.values.singleWhere(
      (element) => element.name == name,
      orElse: () {
        debugPrint(name);
        throw UndefinedWeather(message: 'Unexpected weather condition: $name',);
      },
    );
  }
}
