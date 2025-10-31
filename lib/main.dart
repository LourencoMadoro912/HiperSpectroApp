import 'package:flutter/material.dart';
import 'views/home_screen.dart';
import 'views/input_screen.dart';
import 'views/simulated_screen.dart';

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
        primaryColor: const Color(0xFF135BEC),
        scaffoldBackgroundColor: const Color(0xFFE0E5EC),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF135BEC),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/input': (context) => const SimulationScreen(),
      },
    );
  }
}
