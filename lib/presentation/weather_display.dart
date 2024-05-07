import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/gen/assets.gen.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:flutter_training/presentation/weather_screen_state_controller.dart';

class WeatherDisplay extends ConsumerWidget {
  const WeatherDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentWeather =
        ref.watch(weatherScreenStateControllerProvider).currentWeather;
    return Column(
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: currentWeather == null
              ? const Placeholder()
              : currentWeather.weatherCondition.image,
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              _TemperatureText(
                text: currentWeather != null
                    ? '${currentWeather.minTemperature}'
                    : '** ℃',
                color: Colors.blue,
              ),
              _TemperatureText(
                text: currentWeather != null
                    ? '${currentWeather.maxTemperature}'
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
