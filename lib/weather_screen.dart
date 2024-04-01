import 'package:flutter/material.dart';

class WeatherScreen extends StatelessWidget {
  const WeatherScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const margin = SizedBox(height: 80);
    return Scaffold(
      body: Center(
        child: FractionallySizedBox(
          widthFactor: 1 / 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _placeholderImage(),
              _temperatureRow(context),
              margin,
              _buttonRow(),
            ],
          ),
        ),
      ),
    );
  }

  AspectRatio _placeholderImage() {
    return const AspectRatio(
      aspectRatio: 1 / 1,
      child: Placeholder(),
    );
  }

  Row _temperatureRow(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              '** ℃',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.blue),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Text(
              '** ℃',
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.copyWith(color: Colors.red),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ],
    );
  }

  Row _buttonRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        TextButton(
          onPressed: () => debugPrint('タップ - close'),
          child: const Text('close', style: TextStyle(color: Colors.blue)),
        ),
        TextButton(
          onPressed: () => debugPrint('タップ - reload'),
          child: const Text('reload', style: TextStyle(color: Colors.blue)),
        ),
      ],
    );
  }
}
