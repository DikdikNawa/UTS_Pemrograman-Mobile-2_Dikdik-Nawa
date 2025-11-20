import 'package:flutter/material.dart';
import '../services/weather_service.dart';
import '../models/weather.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _ctr = TextEditingController();
  final WeatherService _service = WeatherService();
  WeatherData? result;
  bool loading = false;

  @override
  void dispose() {
    _ctr.dispose();
    super.dispose();
  }

  Future<void> _search() async {
    final q = _ctr.text.trim();
    if (q.isEmpty) return;

    setState(() {
      loading = true;
      result = null;
    });

    final w = await _service.fetchWeatherByCity(q);

    setState(() {
      loading = false;
      result = w;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cari Kota'),
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // TextField modern
            TextField(
              controller: _ctr,
              decoration: InputDecoration(
                hintText: 'Masukkan nama kota (contoh: Bandung)',
                filled: true,
                fillColor: const Color.fromARGB(255, 136, 205, 255),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: IconButton(
                  onPressed: _search,
                  icon: const Icon(Icons.search, color: Colors.blueAccent),
                ),
              ),
              onSubmitted: (_) => _search(),
            ),

            const SizedBox(height: 16),

            // Loading indicator
            if (loading)
              const Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              ),

            const SizedBox(height: 16),

            // Hasil pencarian
            if (!loading && result != null)
              Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
                color: const Color.fromARGB(255, 213, 237, 255),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Hasil: ${result!.cityName}',
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text('Suhu: ${result!.temperature} °C', style: const TextStyle(fontSize: 16)),
                      Text('Kondisi: ${result!.description}', style: const TextStyle(fontSize: 16)),
                      const SizedBox(height: 16),
                      Center(
                        child: ElevatedButton.icon(
                          icon: const Icon(Icons.check_circle),
                          label: const Text("Gunakan Kota Ini"),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blueAccent,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          ),
                          onPressed: () {
                            Navigator.pop(context, result!.cityName);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
