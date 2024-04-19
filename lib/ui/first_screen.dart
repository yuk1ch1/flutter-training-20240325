import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_training/router_config.dart';
import 'package:flutter_training/ui/on_end_of_frame_mixin.dart';

class FirstScreen extends StatefulWidget {
  const FirstScreen({super.key});

  @override
  State<FirstScreen> createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> with OnEndOfFrameMixin {

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: Colors.green);
  }

  @override
  Future<void> actionOnEndOfFrame() async {
    unawaited(_navigateToWeather());
  }

  Future<void> _navigateToWeather() async {
    const fiveSeconds = Duration(milliseconds: 500);
    await Future<void>.delayed(fiveSeconds);
    if (mounted) {
      await const WeatherPageRoute().push<void>(context);
    }
    unawaited(_navigateToWeather());
  }
}
