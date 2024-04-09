enum WeatherCondition {
  sunny,
  cloudy,
  rainy;

  factory WeatherCondition.from(String name) {
    return WeatherCondition.values.singleWhere(
      (element) => element.name == name,
      orElse: () => throw Exception('Unexpected weather condition: $name'),
    );
  }
}
