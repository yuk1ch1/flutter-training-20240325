import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/gen/assets.gen.dart';
import 'package:flutter_training/model/weather_condition.dart';

class WeatherImage extends StatelessWidget {
  const WeatherImage({
    required WeatherCondition? currentWeather,
    super.key,
  }) : _currentWeather = currentWeather;

  final WeatherCondition? _currentWeather;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: _currentWeather == null
          ? const Placeholder()
          : _currentWeather.image,
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
