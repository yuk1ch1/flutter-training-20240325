import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_exception.dart';
import 'package:flutter_training/model/weather_response.dart';
import 'package:flutter_training/model/yumemi_weather_provider.dart';
import 'package:flutter_training/presentation/screen/weather/weather_display.dart';
import 'package:flutter_training/presentation/screen/weather/weather_screen.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

import 'weather_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<YumemiWeather>()])
void main() {
  final yumemiWeatherMock = MockYumemiWeather();

  tearDown(() => reset(yumemiWeatherMock));

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
            yumemiWeatherProvider.overrideWithValue(
              yumemiWeatherMock,
            ),
          ],
          child: const MaterialApp(home: WeatherScreen()),
        ),
      );

      when(
        yumemiWeatherMock.fetchWeather(any),
      ).thenReturn(_WeatherResponseSample.weatherResponseJson('sunny'));

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

    for (final condition in WeatherCondition.values) {
      testWidgets('レスポンスが${condition.name}の時_${condition.name}の画像が表示される',
          (tester) async {
        // Given
        initializeDeviceSize(tester);
        await tester.pumpWidget(
          ProviderScope(
            overrides: [
              yumemiWeatherProvider.overrideWithValue(yumemiWeatherMock),
            ],
            child: const MaterialApp(home: WeatherScreen()),
          ),
        );

        when(yumemiWeatherMock.fetchWeather(any)).thenReturn(
          _WeatherResponseSample.weatherResponseJson(condition.name),
        );

        // When
        await tester.tap(find.byKey(WeatherScreen.reloadButton));
        await tester.pump();

        // Then
        expect(find.bySemanticsLabel(condition.name), findsOneWidget);
      });
    }

    testWidgets('エラーが返ってきた時、ダイアログを表示する', (tester) async {
      // Given
      initializeDeviceSize(tester);
      await tester.pumpWidget(
        ProviderScope(
          overrides: [
            yumemiWeatherProvider.overrideWithValue(yumemiWeatherMock),
          ],
          child: const MaterialApp(home: WeatherScreen()),
        ),
      );

      when(
        yumemiWeatherMock.fetchWeather(any),
      ).thenThrow(YumemiWeatherError.unknown);

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
  static String weatherResponseJson(String weatherCondition) => '''
    {
      "weather_condition": "$weatherCondition",
      "max_temperature": $maxTemperature,
      "min_temperature": $minTemperature
    }
    ''';
}
