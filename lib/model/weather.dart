import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_exception.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class Weather {
  const Weather({required YumemiWeather client}) : _client = client;
  final YumemiWeather _client;

  WeatherCondition? fetch() {
    try {
      final response = _client.fetchThrowsWeather('Tokyo');
      return WeatherCondition.from(response);
    } on YumemiWeatherError catch (e) {
      return switch (e) {
        YumemiWeatherError.invalidParameter =>
          throw const InvalidParameter(message: '入力情報に誤りがあります。入力情報をご確認ください'),
        YumemiWeatherError.unknown =>
          throw const UnknownWeather(message: '天気情報の取得に失敗しました。時間をおいて再度お試しください'),
      };
    } on UndefinedWeather catch (e) {
      debugPrint(e.toString());
      throw const UndefinedWeather(message: '天気情報の取得に失敗しました。適切な情報を取得できませんでした');
    } on Exception catch (e) {
      debugPrint(e.toString());
      throw const UnexpectedException(
        message: '予期せぬエラーが発生しました。再度時間をおいてお試しください',
      );
    }
  }
}
