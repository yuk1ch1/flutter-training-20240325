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

  tearDown(() => container.dispose());

  group('WeatherScreenで利用する状態の更新テスト', () {
    test('状態更新テスト_初期状態', () {
      // Then
      expect(
        container.read(weatherScreenStateControllerProvider),
        const WeatherScreenState.initial(),
      );
    });

    test('状態更新テスト_更新成功した場合', () async {
      // Given
      const dummyResponse = WeatherResponse(
        weatherCondition: WeatherCondition.cloudy,
        maxTemperature: 21,
        minTemperature: 7,
      );

      const expectedResponse = WeatherScreenState.success(
        weather: dummyResponse,
      );

      provideDummy<Result<WeatherResponse, AppException>>(
        const Success(dummyResponse),
      );

      when(mock.fetch(any)).thenAnswer(
        (_) async =>
            const Success<WeatherResponse, AppException>(dummyResponse),
      );

      // When
      await controller.update(request);

      // Then
      expect(
        controller.state,
        expectedResponse,
      );
    });

    test('状態更新テスト_更新失敗した場合', () async {
      // Given
      const expectedResponse = UnknownWeather();

      provideDummy<Result<WeatherResponse, AppException>>(
        const Failure(
          UnknownWeather(),
        ),
      );

      when(mock.fetch(any)).thenAnswer(
        (_) async => const Failure<WeatherResponse, AppException>(
          expectedResponse,
        ),
      );

      // When
      await controller.update(request);

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
