import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/model/weather.dart';
import 'package:flutter_training/model/weather_exception.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/model/weather_response.dart';
import 'package:flutter_training/presentation/exception_dialog.dart';
import 'package:flutter_training/presentation/weather_display.dart';
import 'package:go_router/go_router.dart';
import 'package:yumemi_weather/yumemi_weather.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final _weather = Weather(client: YumemiWeather());
  WeatherResponse? _currentWeather;
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
              WeatherDisplay(
                currentWeather: _currentWeather,
              ),
              Flexible(
                child: Column(
                  children: [
                    margin,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        TextButton(
                          onPressed: () => context.pop(),
                          child: const Text(
                            'close',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            final result = _weather.fetch(
                              WeatherRequest(
                                area: 'Tokyo',
                                date: DateTime.now(),
                              ),
                            );
                            switch (result) {
                              case Success(value: final weather):
                                setState(() {
                                  _currentWeather = weather;
                                });
                              case Failure(exception: final exception):
                                _showDialog(exception);
                            }
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

  void _showDialog(AppException e) {
    return unawaited(
      showDialog(
        context: context,
        builder: (context) {
          return ExceptionDialog(message: e.message);
        },
      ),
    );
  }
}
