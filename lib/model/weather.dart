import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_training/model/weather_exception.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/model/weather_response.dart';
import 'package:flutter_training/model/yumemi_weather_provider.dart';
import 'package:json_annotation/json_annotation.dart'
    show CheckedFromJsonException;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

part 'weather.g.dart';

@riverpod
Weather weather(WeatherRef ref) {
  final client = ref.watch(yumemiWeatherProvider);
  return Weather(client: client);
}

class Weather {
  const Weather({required YumemiWeather client}) : _client = client;
  final YumemiWeather _client;

  Future<Result<WeatherResponse, AppException>> fetch(
    WeatherRequest request,
  ) async {
    try {
      final jsonSring = jsonEncode(request);
      final response = await compute(_client.syncFetchWeather, jsonSring);
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
