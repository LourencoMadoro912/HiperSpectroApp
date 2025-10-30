import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFE0E5EC), Color(0xFFA3B8D4)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              const Spacer(),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 112,
                    height: 112,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          "https://lh3.googleusercontent.com/aida-public/AB6AXuDAO2ks2cddh28iNYk1VgUkwRq9MgBRSIutRVqdZtFgiSDZcSiKKr4rgUR-v7Q1jhec7oqxIj8HrTbyAOeCXJVZ1zF2HVt-jmbrliDGDXMX6K-hDCcGksp98jvNLvLpU-xEFZ0noFAqtt1KKEvqWhLuPRocdZN-D2B-Bnlq3GrFi45zC3t8IfIZ5iJKAfIXPkHCU5kK1A1PGOyr_2By4EYQzKV2oRE6u8dnhv3hImHdSffUVQjY4DL6ptTBrQH0TKdJKyl1yK76hfFj",
                        ),
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Hiper Spectro",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2F4858),
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    "Simulador Didático de Absorbância",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Color(0xFF2F4858),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      "Simule o comportamento da absorbância em diferentes temperaturas.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xCC2F4858),
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/input');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF135BEC),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      "Iniciar Simulação",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
