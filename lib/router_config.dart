import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_training/ui/first_screen.dart';
import 'package:flutter_training/ui/weather_screen.dart';
import 'package:go_router/go_router.dart';

part 'router_config.g.dart';

final routerConfig = GoRouter(
  routes: $appRoutes,
  debugLogDiagnostics: kDebugMode,
);

/// 最初に表示される背景色緑色の画面
@TypedGoRoute<FirstScreenRoute>(
  path: FirstScreenRoute.path,
)
@immutable
class FirstScreenRoute extends GoRouteData {
  const FirstScreenRoute();

  static const path = '/';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const FirstScreen();
  }
}

/// お天気画面
@TypedGoRoute<WeatherPageRoute>(
  path: WeatherPageRoute.path,
)
@immutable
class WeatherPageRoute extends GoRouteData {
  const WeatherPageRoute();

  static const path = '/weather';

  @override
  Widget build(BuildContext context, GoRouterState state) {
    return const WeatherScreen();
  }
}
