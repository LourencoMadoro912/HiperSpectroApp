import 'package:flutter/material.dart';
import 'views//home_screen.dart';
import 'views//input_screen.dart';

void main() {
  runApp(const HiperSpectroApp());
}

class HiperSpectroApp extends StatelessWidget {
  const HiperSpectroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Hiper Spectro',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Space Grotesk',
        brightness: Brightness.light,
        primaryColor: const Color(0xFF135BEC),
        scaffoldBackgroundColor: const Color(0xFFF6F6F8),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: const Color(0xFF135BEC),
        scaffoldBackgroundColor: const Color(0xFF101622),
      ),
      themeMode: ThemeMode.system,
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/input': (context) => const SimulationScreen(),
      },
    );
  }
}
