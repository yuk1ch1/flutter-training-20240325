import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_exception.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/model/weather_response.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_test.mocks.dart';

@GenerateNiceMocks([MockSpec<YumemiWeather>()])
void main() {
  late MockYumemiWeather mockYumemiWeather;
  late ProviderContainer container;
  final request = WeatherRequest(
    area: 'tokyo',
    date: DateTime.now(),
  );

  setUp(() {
    mockYumemiWeather = MockYumemiWeather();
    container = ProviderContainer(
      overrides: [
        weatherProvider.overrideWithValue(
          Weather(client: mockYumemiWeather),
        ),
      ],
    );
  });

  tearDown(() {
    container.dispose();
  });

  group('天気情報取得のテスト', () {
    test(
      '天気情報取得に成功_正常なレスポンスを返した場合',
      () async {
        // Given
        when(
          mockYumemiWeather.syncFetchWeather(any),
        ).thenReturn(
          '''
            {
              "weather_condition": "sunny",
              "max_temperature": 30,
              "min_temperature": 20,
              "date": "2020-04-01T12:00:00+09:00"
            }
        ''',
        );

        // When
        final response = await container.read(weatherProvider).fetch(request);

        const expectedResponse = WeatherResponse(
          weatherCondition: WeatherCondition.sunny,
          maxTemperature: 30,
          minTemperature: 20,
        );

        // Then
        expect(
          response,
          isA<Success<WeatherResponse, AppException>>().having(
            (success) => success.value,
            'expected WeatherResponse',
            expectedResponse,
          ),
        );
      },
    );

    test('天気情報取得に失敗_APIがInvalidParameter返した場合', () async {
      when(
        mockYumemiWeather.syncFetchWeather(any),
      ).thenThrow(YumemiWeatherError.invalidParameter);

      // When
      final response = await container.read(weatherProvider).fetch(request);

      const expectedResponse = InvalidParameter();

      // Then
      expect(
        response,
        isA<Failure<WeatherResponse, AppException>>().having(
          (failure) => failure.exception,
          'AppException',
          expectedResponse,
        ),
      );
    });

    test('天気情報取得に失敗_APIが不明なエラーを返した場合', () async {
      when(
        mockYumemiWeather.syncFetchWeather(any),
      ).thenThrow(YumemiWeatherError.unknown);

      // When
      final response = await container.read(weatherProvider).fetch(request);

      const expectedResponse = UnknownWeather();

      // Then
      expect(
        response,
        isA<Failure<WeatherResponse, AppException>>().having(
          (failure) => failure.exception,
          'AppException',
          expectedResponse,
        ),
      );
    });

    test('天気情報取得に失敗_APIがアプリ側未定義の天気を返した場合', () async {
      when(
        mockYumemiWeather.syncFetchWeather(any),
      ).thenReturn('''
            {
              "weather_condition": "dummy",
              "max_temperature": 30,
              "min_temperature": 20,
              "date": "2020-04-01T12:00:00+09:00"
            }
        ''');

      // When
      final response = await container.read(weatherProvider).fetch(request);

      const expectedResponse = ResponseFormatException();

      // Then
      expect(
        response,
        isA<Failure<WeatherResponse, AppException>>().having(
          (failure) => failure.exception,
          'AppException',
          expectedResponse,
        ),
      );
    });
  });
}
