import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_exception.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class Weather {
  const Weather({required YumemiWeather client}) : _client = client;
  final YumemiWeather _client;

  Result<WeatherCondition, AppException> fetch() {
    try {
      final response = _client.fetchThrowsWeather('Tokyo');
      return Success(WeatherCondition.from(response));
    } on YumemiWeatherError catch (e) {
      return switch (e) {
        YumemiWeatherError.invalidParameter =>
          const Failure(InvalidParameter(message: '入力情報に誤りがあります。入力情報をご確認ください')),
        YumemiWeatherError.unknown =>
          const Failure(UnknownWeather(message: '天気情報の取得に失敗しました。時間をおいて再度お試しください'),),
      };
    } on UndefinedWeather catch (e) {
      debugPrint(e.toString());
      return const Failure(UndefinedWeather(message: '天気情報の取得に失敗しました。適切な情報を取得できませんでした'),);
    } on Exception catch (e) {
      debugPrint(e.toString());
      return const Failure(UnexpectedException(message: '予期せぬエラーが発生しました。再度時間をおいてお試しください'),);
    }
  }
}

sealed class Result<S, E extends AppException> {
  const Result();
}

final class Success<S, E extends AppException> extends Result<S, E> {
  const Success(this.value);
  final S value;
}

final class Failure<S, E extends AppException> extends Result<S, E> {
  const Failure(this.exception);
  final E exception;
}
