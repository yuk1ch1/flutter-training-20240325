sealed class AppException implements Exception {
  const AppException({required this.message});
  final String message;
}

/// Domainエラー
final class UndefinedWeather extends AppException {
  const UndefinedWeather() : super(message: '天気情報の取得に失敗しました。適切な情報を取得できませんでした');
}

/// APIエラー
sealed class WeatherAPIException extends AppException {
  const WeatherAPIException({required super.message});
}

final class InvalidParameter extends WeatherAPIException {
  const InvalidParameter() : super(message: '入力情報に誤りがあります。入力情報をご確認ください');
}

final class UnknownWeather extends WeatherAPIException {
  const UnknownWeather() : super(message: '天気情報の取得に失敗しました。時間をおいて再度お試しください');
}

/// 想定外のエラー
final class UnexpectedException extends AppException {
  const UnexpectedException()
      : super(message: '予期せぬエラーが発生しました。再度時間をおいてお試しください');
}
