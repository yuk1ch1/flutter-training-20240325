sealed class AppException implements Exception {
  const AppException({ required this.message });
  final String message;
}

/// Domainエラー
final class UndefinedWeather extends AppException {
  const UndefinedWeather({ required super.message });
}


/// APIエラー
sealed class WeatherAPIException extends AppException {
  const WeatherAPIException({ required super.message });
}

final class InvalidParameter extends WeatherAPIException {
  const InvalidParameter({ required super.message });
}

final class UnknownWeather extends WeatherAPIException {
  const UnknownWeather({ required super.message });
}

/// 想定外のエラー
final class UnexpectedException extends AppException {
  const UnexpectedException({ required super.message});
}
