import 'package:flutter_training/model/weather_response.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_screen_state.freezed.dart';

@freezed
sealed class WeatherScreenState with _$WeatherScreenState {
  const factory WeatherScreenState.initial() = _Initial;
  const factory WeatherScreenState.loading(
      {required WeatherResponse? weather,}) = _Loading;
  const factory WeatherScreenState.success({required WeatherResponse weather}) =
      _Success;
  const factory WeatherScreenState.error({required String message}) = _Error;

  const WeatherScreenState._();

  WeatherResponse? get currentWeather => when(
        initial: () => null,
        loading: (weather) => weather,
        success: (weather) => weather,
        error: (_) => null,
      );

  bool get isLoading => maybeWhen(
        loading: (_) => true,
        orElse: () => false,
      );
}
