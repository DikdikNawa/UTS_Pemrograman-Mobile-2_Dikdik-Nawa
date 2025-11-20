import 'package:flutter/material.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import 'package:cached_network_image/cached_network_image.dart';

class WeatherCard extends StatelessWidget {
  final WeatherData weather;
  final WeatherService _service = WeatherService();

  WeatherCard({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          children: [
            CachedNetworkImage(
              imageUrl: _service.iconUrl(weather.icon),
              width: 80,
              height: 80,
              placeholder: (context, url) => const SizedBox(width: 80, height: 80, child: Center(child: CircularProgressIndicator())),
              errorWidget: (context, url, error) => const Icon(Icons.cloud, size: 64),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(weather.cityName, style: Theme.of(context).textTheme.titleMedium),
                  const SizedBox(height: 4),
                  Text('${weather.temperature.toStringAsFixed(1)} °C', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text(weather.description),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
