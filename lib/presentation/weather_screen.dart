import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_training/model/weather_request.dart';
import 'package:flutter_training/presentation/exception_dialog.dart';
import 'package:flutter_training/presentation/weather_display.dart';
import 'package:flutter_training/presentation/weather_screen_state_controller.dart';
import 'package:go_router/go_router.dart';

class WeatherScreen extends ConsumerWidget {
  const WeatherScreen({super.key});

  static const margin = SizedBox(height: 80);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(
      weatherScreenStateControllerProvider,
      (_, next) {
        next.whenOrNull(
          error: (message) {
            _showDialog(message, context);
          },
        );
      },
    );
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 1 / 2,
          child: Column(
            children: [
              const Spacer(),
              const WeatherDisplay(),
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
                            ref
                                .read(
                                  weatherScreenStateControllerProvider.notifier,
                                )
                                .update(
                                  WeatherRequest(
                                    area: 'Tokyo',
                                    date: DateTime.now(),
                                  ),
                                );
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

  void _showDialog(String message, BuildContext context) {
    return unawaited(
      showDialog(
        context: context,
        builder: (context) {
          return ExceptionDialog(message: message);
        },
      ),
    );
  }
}