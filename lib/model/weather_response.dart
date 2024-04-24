import 'package:flutter_training/model/weather_condition.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_response.freezed.dart';
part 'weather_response.g.dart';

@freezed
class WeatherResponse with _$WeatherResponse {
  const factory WeatherResponse({
    @JsonKey(name: 'weather_condition')
    required WeatherCondition weatherCondition,
    @JsonKey(name: 'max_temperature') required int maxTemperature,
    @JsonKey(name: 'min_temperature') required int minTemperature,
  }) = _WeatherResponse;

  factory WeatherResponse.fromJson(Map<String, dynamic> json) =>
      _$WeatherResponseFromJson(json);
}
