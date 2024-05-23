import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_exception.dart';
import 'package:flutter_training/model/weather_response.dart';
import 'package:flutter_training/presentation/screen/weather/weather_display.dart';
import 'package:flutter_training/presentation/screen/weather/weather_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'weather_screen_test.mocks.dart';

// import 'package:yumemi_weather/yumemi_weather.dart';
@GenerateNiceMocks([MockSpec<Weather>()])
void main() {
  final weatherMock = MockWeather();

  tearDown(() => reset(weatherMock));

  /// 小さい端末でのテストのために設定
  ///
  /// 設定しない場合デフォルトサイズでは
  /// "A RenderFlex overflowed by XXX pixels on some part."となってしまう問題への対応
  void initializeDeviceSize(WidgetTester tester) {
    const iPhoneSE3 = Size(750, 1334);
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = iPhoneSE3;
  }

  testWidgets('最初に表示された時_プレースホルダー画像とデフォルトの気温が表示される', (tester) async {
    // Given
    initializeDeviceSize(tester);
    await tester.pumpWidget(
      const ProviderScope(
        child: MaterialApp(
          home: WeatherScreen(),
        ),
      ),
    );

    // Then
    expect(find.byType(Placeholder), findsOneWidget);
    expect(find.text(WeatherDisplay.defaultTemperature), findsNWidgets(2));
  });

  group('リロードボタンタップ時のテスト', () {
    testWidgets('天候に関係なく最低気温と最高気温が表示される', (tester) async {
      // Given
      initializeDeviceSize(tester);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherProvider.overrideWithValue(
              weatherMock,
            ),
          ],
          child: const MaterialApp(home: WeatherScreen()),
        ),
      );

      provideDummy<Result<WeatherResponse, AppException>>(
        Success(_WeatherResponseSample.sample(WeatherCondition.sunny)),
      );

      when(
        weatherMock.fetch(any),
      ).thenAnswer(
        (_) async => Success<WeatherResponse, AppException>(
          _WeatherResponseSample.sample(WeatherCondition.sunny),
        ),
      );

      // When
      await tester.tap(find.byKey(WeatherScreen.reloadButton));
      await tester.pump();

      // Then
      expect(find.text(WeatherDisplay.defaultTemperature), findsNothing);
      expect(
        find.text('${_WeatherResponseSample.maxTemperature}'),
        findsOneWidget,
      );
      expect(
        find.text('${_WeatherResponseSample.minTemperature}'),
        findsOneWidget,
      );
    });

    for (final weatherCondition in WeatherCondition.values) {
      testWidgets(
          'レスポンスが${weatherCondition.name}の時_${weatherCondition.name}の画像が表示される',
          (tester) async {
        // Given
        initializeDeviceSize(tester);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              weatherProvider.overrideWithValue(weatherMock),
            ],
            child: const MaterialApp(home: WeatherScreen()),
          ),
        );

        provideDummy<Result<WeatherResponse, AppException>>(
          Success(_WeatherResponseSample.sample(weatherCondition)),
        );

        when(weatherMock.fetch(any)).thenAnswer(
          (_) async => Success<WeatherResponse, AppException>(
            _WeatherResponseSample.sample(weatherCondition),
          ),
        );
        // When
        await tester.tap(find.byKey(WeatherScreen.reloadButton));
        await tester.pump();

        // Then
        expect(find.bySemanticsLabel(weatherCondition.name), findsOneWidget);
      });
    }

    testWidgets('エラーが返ってきた時、ダイアログを表示する', (tester) async {
      // Given
      initializeDeviceSize(tester);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            weatherProvider.overrideWithValue(weatherMock),
          ],
          child: const MaterialApp(home: WeatherScreen()),
        ),
      );

      provideDummy<Result<WeatherResponse, AppException>>(
        const Failure(
          UnknownWeather(),
        ),
      );

      when(
        weatherMock.fetch(any),
      ).thenAnswer(
        (_) async => const Failure<WeatherResponse, AppException>(
          UnknownWeather(),
        ),
      );
      // .thenThrow(YumemiWeatherError.unknown);

      // When
      await tester.tap(find.byKey(WeatherScreen.reloadButton));
      await tester.pump();

      // Then
      expect(find.byType(AlertDialog), findsOneWidget);
      expect(find.text(const UnknownWeather().message), findsOneWidget);
    });
  });
}

extension _WeatherResponseSample on WeatherResponse {
  static int get maxTemperature => 25;
  static int get minTemperature => 7;

  static WeatherResponse sample(WeatherCondition weatherCondition) =>
      WeatherResponse(
        weatherCondition: weatherCondition,
        maxTemperature: maxTemperature,
        minTemperature: minTemperature,
      );
}
