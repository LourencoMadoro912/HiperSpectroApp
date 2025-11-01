import 'dart:async';
import 'package:flutter/material.dart';
import 'home_screen.dart'; // substitui pelo nome da tua tela principal

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Espera 3 segundos e depois vai para a tela principal
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // muda a cor se quiser
      body: Center(
        child: Image.asset(
          'assets/splash.projecto_flutter_imagem.png',
          width: 200, // ajusta o tamanho conforme quiser
          height: 200,
          fit: BoxFit.contain,
        ),
      ),
    );
  }
}
