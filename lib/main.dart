 // ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Ekranlar
import 'screens/login.dart';
import 'screens/dashboard.dart';
import 'screens/ai_offer.dart';
import 'screens/history.dart';
import 'screens/stats.dart';
import 'screens/profile.dart';

void main() {
  runApp(const EnerjiXApp());
}

class EnerjiXApp extends StatefulWidget {
  const EnerjiXApp({super.key});

  @override
  _EnerjiXAppState createState() => _EnerjiXAppState();
}

class _EnerjiXAppState extends State<EnerjiXApp> {
  int _selectedIndex = 0; // ilk açılış: Login
  bool _isLoggedIn = false;

  void _handleLogin(String email, String password) {
    setState(() {
      _isLoggedIn = true;
      _selectedIndex = 1; // Dashboard-a yönləndir
    });
  }

  void _onItemTapped(int index) {
    // Login ekranı açıldıqdan sonra yalnız login üçün index = 0 işləsin
    if (!_isLoggedIn && index != 0) return;
    setState(() {
      _selectedIndex = index;
    });
  }

  final ThemeData _theme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF00C853)),
    primaryColor: const Color(0xFF00C853),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.white,
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF263238)),
    ),
    textTheme: GoogleFonts.poppinsTextTheme(),
    visualDensity: VisualDensity.adaptivePlatformDensity,
  );

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      LoginScreen(onLogin: _handleLogin),
      const DashboardScreen(),
      const AiOfferScreen(),
      const HistoryScreen(),
      const StatsScreen(),
      const ProfileScreen(),
    ];

    return MaterialApp(
      title: 'EnerjiX',
      debugShowCheckedModeBanner: false,
      theme: _theme,
      home: Scaffold(
        body: SafeArea(child: screens[_selectedIndex]),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: const Color(0xFF00C853),
          unselectedItemColor: Colors.grey.shade600,
          onTap: _onItemTapped,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.login), label: "Giriş"),
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: "Panel"),
            BottomNavigationBarItem(icon: Icon(Icons.bolt), label: "AI"),
            BottomNavigationBarItem(icon: Icon(Icons.history), label: "Tarixçə"),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: "Statistika"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profil"),
          ],
        ),
      ),
    );
  }
}
