import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/gen/assets.gen.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/model/weather_response.dart';

class WeatherDisplay extends StatelessWidget {
  const WeatherDisplay({required WeatherResponse? currentWeather, super.key})
      : _currentWeather = currentWeather;

  final WeatherResponse? _currentWeather;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: _currentWeather == null
              ? const Placeholder()
              : _currentWeather.weatherCondition.image,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _TemperatureText(
                text: _currentWeather != null
                    ? '${_currentWeather.minTemperature}'
                    : '** ℃',
                color: Colors.blue,
              ),
              _TemperatureText(
                text: _currentWeather != null
                    ? '${_currentWeather.maxTemperature}'
                    : '** ℃',
                color: Colors.red,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _TemperatureText extends StatelessWidget {
  const _TemperatureText({
    required String text,
    required Color color,
  })  : _color = color,
        _text = text;

  final String _text;
  final Color _color;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme.labelLarge!;
    return Expanded(
      child: Text(
        _text,
        style: textTheme.copyWith(color: _color),
        textAlign: TextAlign.center,
      ),
    );
  }
}

extension _WeatherSVGPicture on WeatherCondition {
  SvgPicture get image => switch (this) {
        WeatherCondition.sunny => Assets.images.sunny.svg(),
        WeatherCondition.cloudy => Assets.images.cloudy.svg(),
        WeatherCondition.rainy => Assets.images.rainy.svg(),
      };
}
