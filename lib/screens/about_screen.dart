import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About'),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Text(
                'UTS',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue.shade900,
                ),
              ),
            ),
            const SizedBox(height: 8),

            const Center(
              child: Text(
                'Copyright by: Dikdik Nawa Cendekia Agung_23552011240',
                style: TextStyle(fontSize: 14, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Deskripsi',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Ini adalah aplikasi yang dibuat untuk memenuhi tugas mata kuliah Pemrograman Mobile. Aplikasi ini menampilkan data cuaca real-time menggunakan OpenWeatherMap API.',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              color: Colors.blue.shade50,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Library / Dependencies yang digunakan',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const LibraryItem(name: 'flutter', description: 'SDK utama Flutter'),
                    const LibraryItem(name: 'http', description: 'Untuk melakukan request API, versi ^0.13.6'),
                    const LibraryItem(name: 'shared_preferences', description: 'Menyimpan data lokal, versi ^2.1.1'),
                    const LibraryItem(name: 'flutter_spinkit', description: 'Loading spinner animasi, versi ^5.1.0'),
                    const LibraryItem(name: 'cached_network_image', description: 'Menampilkan dan cache gambar dari network, versi ^3.2.3'),
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
class LibraryItem extends StatelessWidget {
  final String name;
  final String description;

  const LibraryItem({super.key, required this.name, required this.description});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 2, horizontal: 0),
      leading: const Icon(Icons.check_circle, size: 20, color: Colors.blueAccent),
      title: Text(
        name,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(description),
    );
  }
}
