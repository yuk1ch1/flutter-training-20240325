import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather_exception.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/model/weather_response.dart';
import 'package:json_annotation/json_annotation.dart'
    show CheckedFromJsonException;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather.g.dart';

@riverpod
Weather weather(WeatherRef ref) {
  return Weather(client: YumemiWeather());
}

class Weather {
  const Weather({required YumemiWeather client}) : _client = client;
  final YumemiWeather _client;

  Result<WeatherResponse, AppException> fetch(WeatherRequest request) {
    try {
      final jsonSring = jsonEncode(request);
      final response = _client.fetchWeather(jsonSring);
      final responseJSON = jsonDecode(response) as Map<String, dynamic>;
      return Success(WeatherResponse.fromJson(responseJSON));
    } on YumemiWeatherError catch (e) {
      return switch (e) {
        YumemiWeatherError.invalidParameter =>
          const Failure(InvalidParameter()),
        YumemiWeatherError.unknown => const Failure(
            UnknownWeather(),
          ),
      };
    } on UndefinedWeather catch (e) {
      debugPrint(e.toString());
      return const Failure(
        UndefinedWeather(),
      );
    } on CheckedFromJsonException catch (e) {
      debugPrint(e.toString());
      return const Failure(
        ResponseFormatException(),
      );
    } on Exception catch (e) {
      debugPrint(e.toString());
      return const Failure(
        UnexpectedException(),
      );
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
