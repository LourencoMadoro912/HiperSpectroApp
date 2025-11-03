import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

import 'viewmodels/simulation_viewmodel.dart';
import 'views/home_screen.dart';
import 'views/input_screen.dart';
import 'views/simulated_screen.dart';
import 'views/summary_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Tenta inicializar o Firebase. Se não estiver configurado, segue com fallback.
  try {
    await Firebase.initializeApp();
  } catch (e) {
    // Se não configurado (por exemplo, em ambiente local sem google-services), ignore.
    debugPrint('Firebase init failed or not configured: $e');
  }

  runApp(const HiperSpectroApp());
}

class HiperSpectroApp extends StatelessWidget {
  const HiperSpectroApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => SimulationViewModel(),
      child: MaterialApp(
        title: 'Hiper Spectro',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        routes: {
          '/input': (_) => const InputScreen(),
          // simulated and summary are constructed with parameters, so we use Navigator pushes
        },
      ),
    );
  }
}
