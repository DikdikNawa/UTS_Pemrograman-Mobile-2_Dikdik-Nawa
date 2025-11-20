import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_screen.dart';
import 'search_screen.dart';
import 'about_screen.dart';
import '../models/weather.dart';
import '../services/weather_service.dart';
import '../widgets/weather_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final _pages = const [
    HomeMainTab(),
    AboutScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: _pages[_currentIndex],

      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.15),
              blurRadius: 12,
              offset: const Offset(0, -2),
            )
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(22)),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blueAccent,
            unselectedItemColor: Colors.grey.shade500,
            onTap: (i) => setState(() => _currentIndex = i),
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home_rounded), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.info_rounded), label: "About"),
            ],
          ),
        ),
      ),

      appBar: AppBar(
        title: const Text(
          "Cuaca bin Weather",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout_rounded),
            onPressed: () async {
              final prefs = await SharedPreferences.getInstance();
              await prefs.clear();
              if (!mounted) return;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (_) => LoginScreen(prefs: prefs)),
              );
            },
          )
        ],
      ),
    );
  }
}

class HomeMainTab extends StatefulWidget {
  const HomeMainTab({super.key});

  @override
  State<HomeMainTab> createState() => _HomeMainTabState();
}

class _HomeMainTabState extends State<HomeMainTab> {
  final WeatherService _service = WeatherService();

  String _city = "Jakarta";
  WeatherData? current;

  @override
  void initState() {
    super.initState();
    _fetch(_city);
  }

  Future<void> _fetch(String city) async {
    current = await _service.fetchWeatherByCity(city);
    setState(() {});
  }

  String getDefaultGif() => "asset/sun.gif";

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xff4facfe), Color(0xff00f2fe)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: RefreshIndicator(
        onRefresh: () => _fetch(_city),
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            current == null
                ? const Center(child: CircularProgressIndicator())
                : Column(
                    children: [
                      Image.asset(getDefaultGif(), width: 200),
                      const SizedBox(height: 16),
                      Text(
                        "Cuaca di $_city",
                        style: const TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      WeatherCard(weather: current!),
                      const SizedBox(height: 14),
                    ],
                  ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              icon: const Icon(Icons.search_rounded),
              label: const Text("Cari Kota Lain"),
              onPressed: () async {
                final result = await Navigator.push<String?>(
                  context,
                  MaterialPageRoute(builder: (_) => const SearchScreen()),
                );

                // Jika user pilih kota, update langsung
                if (result != null && result.isNotEmpty) {
                  _city = result;
                  _fetch(_city);
                }
              },
            ),
            const SizedBox(height: 12),
            const Center(
              child: Text(
                "Tarik ke bawah untuk refresh",
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
            ),
          ],
        ),
      ),
    );
  }
}