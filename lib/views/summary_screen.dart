import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'input_screen.dart';

class SummaryScreen extends StatelessWidget {
  final int temperature;
  final double absorbance;
  final String totalTime;

  const SummaryScreen({
    super.key,
    required this.temperature,
    required this.absorbance,
    required this.totalTime,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? const Color(0xFF101622) : const Color(0xFFF5F7FA);
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            // App bar personalizada
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              color: isDark ? const Color(0xFF101622) : Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back, color: textColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const Spacer(),
                  Text(
                    "Resumo da Simulação",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 32),
                child: Column(
                  children: [
                    Text(
                      "Simulação Concluída",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "Aqui estão os resultados da sua simulação.",
                      style: TextStyle(
                        color: textColor.withOpacity(0.8),
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _resultCard(
                      context,
                      icon: Icons.device_thermostat,
                      label: "Temperatura Inserida",
                      value: "$temperature°C",
                      color: const Color(0xFF0D47A1),
                    ),
                    const SizedBox(height: 16),
                    _resultCard(
                      context,
                      icon: Icons.analytics,
                      label: "Média de Absorbância",
                      value: absorbance.toStringAsFixed(3),
                      color: const Color(0xFF00A99D),
                      isAccent: true,
                    ),
                    const SizedBox(height: 16),
                    _resultCard(
                      context,
                      icon: Icons.timer,
                      label: "Tempo Total",
                      value: totalTime,
                      color: const Color(0xFF0D47A1),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const InputScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Center(
                      child: Text(
                        "Nova Simulação",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  OutlinedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (_) => const HomeScreen()),
                            (route) => false,
                      );
                    },
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF0D47A1)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: const Center(
                      child: Text(
                        "Voltar ao Início",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color(0xFF0D47A1),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resultCard(
      BuildContext context, {
        required IconData icon,
        required String label,
        required String value,
        required Color color,
        bool isAccent = false,
      }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? Colors.grey[900]! : Colors.white;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(16),
        border: isAccent
            ? Border.all(color: color.withOpacity(0.7), width: 1.5)
            : null,
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(width: 12),
              Text(
                label,
                style: TextStyle(
                  color: isDark ? Colors.white70 : Colors.black87,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
