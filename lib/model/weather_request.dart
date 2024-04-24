import 'package:json_annotation/json_annotation.dart';

part 'weather_request.g.dart';

@JsonSerializable()
class WeatherRequest {
  const WeatherRequest({
    required this.area,
    required this.date,
  });
  final String area;
  final DateTime date;

  Map<String, dynamic> toJson() => _$WeatherRequestToJson(this);
}
