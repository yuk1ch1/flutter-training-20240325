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
