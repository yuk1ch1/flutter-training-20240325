import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/model/weather_condition.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _model = Weather(client: YumemiWeather());
  WeatherCondition? _currentWeather;
  static const margin = SizedBox(height: 80);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 1 / 2,
          child: Column(
            children: [
              const Spacer(),
              _WeatherImage(currentWeather: _currentWeather),
              const Padding(
                padding: EdgeInsets.all(16),
                child: Row(
                  children: [
                    _TemperatureText(
                      text: '** ℃',
                      color: Colors.blue,
                    ),
                    _TemperatureText(
                      text: '** ℃',
                      color: Colors.red,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: [
                    margin,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => debugPrint('タップ - close'),
                          child: const Text(
                            'close',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _currentWeather = _model.fetch();
                            });
                          },
                          child: const Text(
                            'reload',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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

class _WeatherImage extends StatelessWidget {
  const _WeatherImage({
    required WeatherCondition? currentWeather,
  }) : _currentWeather = currentWeather;

  final WeatherCondition? _currentWeather;

  @override
  Widget build(BuildContext context) {
    // final currentWeather = _currentWeather;
    return AspectRatio(
      aspectRatio: 1,
      child: _currentWeather == null
          ? const Placeholder()
          : _currentWeather!.image,
    );
  }
}

extension _WeatherSVGPicture on WeatherCondition {
  SvgPicture get image {
    switch (this) {
      case WeatherCondition.sunny:
        return SvgPicture.asset('images/sunny.svg');
      case WeatherCondition.cloudy:
        return SvgPicture.asset('images/cloudy.svg');
      case WeatherCondition.rainy:
        return SvgPicture.asset('images/rainy.svg');
    }
  }
}
