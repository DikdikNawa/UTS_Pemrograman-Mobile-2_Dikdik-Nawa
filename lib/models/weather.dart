class WeatherData {
  final String cityName;
  final double temperature;
  final String description;
  final String icon; // icon code from OpenWeather

  WeatherData({
    required this.cityName,
    required this.temperature,
    required this.description,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    final name = json['name'] ?? '';
    final main = json['main'] ?? {};
    final weatherList = json['weather'] as List<dynamic>? ?? [];
    final weather = weatherList.isNotEmpty ? weatherList[0] : {};
    final temp = (main['temp'] ?? 0).toDouble();
    final desc = weather['description'] ?? '';
    final icon = weather['icon'] ?? '';
    return WeatherData(
      cityName: name,
      temperature: temp,
      description: desc,
      icon: icon,
    );
  }
}
