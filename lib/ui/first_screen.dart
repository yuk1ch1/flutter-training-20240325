import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/router_config.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {
  @override
  void initState() {
    super.initState();

    unawaited(_navigateToWeather());
  }

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: Colors.green);
  }

  Future<void> _navigateToWeather() async {
    await WidgetsBinding.instance.endOfFrame;
    const fiveSeconds = Duration(milliseconds: 500);
    await Future<void>.delayed(fiveSeconds);
    if (mounted) {
      await const WeatherPageRoute().push<void>(context);
      unawaited(_navigateToWeather());
    }
  }
}
