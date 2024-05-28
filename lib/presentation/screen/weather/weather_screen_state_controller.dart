import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/presentation/screen/weather/weather_screen_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'weather_screen_state_controller.g.dart';

@riverpod
class WeatherScreenStateController extends _$WeatherScreenStateController {
  @override
  WeatherScreenState build() {
    return const WeatherScreenState.initial();
  }

  Future<void> update(WeatherRequest request) async {
    state = WeatherScreenState.loading(weather: state.currentWeather);
    final response = await ref.read(weatherProvider).fetch(request);
    switch (response) {
      case Success(value: final weather):
        state = WeatherScreenState.success(weather: weather);
      case Failure(exception: final exception):
        state = WeatherScreenState.error(message: exception.message);
    }
  }
}
