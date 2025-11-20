import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/weather.dart';

class WeatherService {
  // Ganti dengan API key kamu dari OpenWeatherMap
  static const apiKey = '35189a1e5868f58f8fd2c4cdcaac5521';

  Future<WeatherData?> fetchWeatherByCity(String city) async {
    try {
      final url =
          'https://api.openweathermap.org/data/2.5/weather?q=${Uri.encodeComponent(city)}&appid=$apiKey&units=metric&lang=id';
      final resp = await http.get(Uri.parse(url));
      if (resp.statusCode == 200) {
        final json = jsonDecode(resp.body) as Map<String, dynamic>;
        return WeatherData.fromJson(json);
      } else {
        return null;
      }
    } catch (e) {
      debugPrint('fetchWeather error: $e');
      return null;
    }
  }

  String iconUrl(String iconCode) => 'https://openweathermap.org/img/wn/$iconCode@2x.png';
}
