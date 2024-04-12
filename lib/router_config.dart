import 'package:flutter_training/first_screen.dart';
import 'package:flutter_training/ui/weather_screen.dart';
import 'package:go_router/go_router.dart';

final routerConfig = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const FirstScreen(),
    ),
    GoRoute(
      path: '/weather',
      builder: (context, state) => const WeatherScreen(),
    ),
  ],
);
