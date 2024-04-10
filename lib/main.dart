import 'package:flutter/material.dart';
import 'package:flutter_training/first_screen.dart';
import 'package:flutter_training/ui/weather_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        '/': (context) => const FirstScreen(),
      },
    );
  }
}
