// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router_config.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [
      $firstScreenRoute,
      $weatherPageRoute,
    ];

RouteBase get $firstScreenRoute => GoRouteData.$route(
      path: '/firstScreen',
      factory: $FirstScreenRouteExtension._fromState,
    );

extension $FirstScreenRouteExtension on FirstScreenRoute {
  static FirstScreenRoute _fromState(GoRouterState state) =>
      const FirstScreenRoute();

  String get location => GoRouteData.$location(
        '/firstScreen',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $weatherPageRoute => GoRouteData.$route(
      path: '/weather',
      factory: $WeatherPageRouteExtension._fromState,
    );

extension $WeatherPageRouteExtension on WeatherPageRoute {
  static WeatherPageRoute _fromState(GoRouterState state) =>
      const WeatherPageRoute();

  String get location => GoRouteData.$location(
        '/weather',
      );

  void go(BuildContext context) => context.go(location);

  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  void replace(BuildContext context) => context.replace(location);
}
