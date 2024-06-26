sealed class AppException implements Exception {
  const AppException({required this.message});
  final String message;
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

final class ResponseFormatException extends WeatherAPIException {
  const ResponseFormatException() : super(message: '天気情報の取得に失敗しました。');
}

/// 想定外のエラー
final class UnexpectedException extends AppException {
  const UnexpectedException()
      : super(message: '予期せぬエラーが発生しました。再度時間をおいてお試しください');
}
