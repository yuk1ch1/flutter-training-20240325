import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/model/weather_response.dart';
import 'package:flutter_training/presentation/weather_screen_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_screen_state_controller.g.dart';

@riverpod
class WeatherScreenStateController extends _$WeatherScreenStateController {
  @override
  WeatherScreenState build() {
    return const WeatherScreenState.initial();
  }

  void update(WeatherRequest request) {
    final response = ref.read(weatherProvider).fetch(request);
    switch (response) {
      case Success(value: final weather):
        state = WeatherScreenState.success(
          weather: WeatherResponse(
            weatherCondition: weather.weatherCondition,
            maxTemperature: weather.maxTemperature,
            minTemperature: weather.minTemperature,
          ),
        );
      case Failure(exception: final exception):
        state = WeatherScreenState.error(message: exception.message);
    }
  }
}
