import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_exception.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/model/weather_response.dart';
import 'package:flutter_training/presentation/screen/weather/weather_screen_state.dart';
import 'package:flutter_training/presentation/screen/weather/weather_screen_state_controller.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_screen_state_controller_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Weather>()])
void main() {
  late MockWeather mock;
  late ProviderContainer container;
  late WeatherScreenStateController controller;
  final request = WeatherRequest(
    area: 'tokyo',
    date: DateTime.now(),
  );

  setUp(() {
    mock = MockWeather();
    container = ProviderContainer(
      overrides: [weatherProvider.overrideWithValue(mock)],
    );
    controller = container.read(weatherScreenStateControllerProvider.notifier);
  });

  tearDown(() {
    container.dispose();
  });

  group('WeatherScreenで利用する状態の更新テスト', () {
    test('状態更新テスト_初期状態', () {
      // Then
      expect(
        container.read(weatherScreenStateControllerProvider),
        const WeatherScreenState.initial(),
      );
    });

    test('状態更新テスト_更新成功した場合', () {
      // Given
      const expectedResponse = WeatherScreenState.success(
        weather: WeatherResponse(
          weatherCondition: WeatherCondition.cloudy,
          maxTemperature: 21,
          minTemperature: 7,
        ),
      );

      provideDummy<Result<WeatherResponse, AppException>>(
        const Success(
          WeatherResponse(
            weatherCondition: WeatherCondition.cloudy,
            maxTemperature: 21,
            minTemperature: 7,
          ),
        ),
      );

      when(mock.fetch(any)).thenReturn(
        const Success<WeatherResponse, AppException>(
          WeatherResponse(
            weatherCondition: WeatherCondition.cloudy,
            maxTemperature: 21,
            minTemperature: 7,
          ),
        ),
      );

      // When
      controller.update(request);

      // Then
      expect(
        controller.state,
        expectedResponse,
      );
    });

    test('状態更新テスト_更新失敗した場合', () {
      // Given
      const expectedResponse = UnknownWeather();

      provideDummy<Result<WeatherResponse, AppException>>(
        const Failure(
          UnknownWeather(),
        ),
      );

      when(mock.fetch(any)).thenReturn(
        const Failure<WeatherResponse, AppException>(
          expectedResponse,
        ),
      );

      // When
      controller.update(request);

      // Then
      expect(
        controller.state,
        WeatherScreenState.error(
          message: expectedResponse.message,
        ),
      );
    });
  });
}
