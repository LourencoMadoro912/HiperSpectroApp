import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/simulation_viewmodel.dart';
import 'simulated_screen.dart';

class InputScreen extends StatefulWidget {
  const InputScreen({super.key});

  @override
  State<InputScreen> createState() => _InputScreenState();
}

class _InputScreenState extends State<InputScreen> {
  final TextEditingController _temperatureController =
  TextEditingController(text: "25");

  final List<int> _suggestedTemperatures = [5, 25, 30, 40];
  int _selectedTemperature = 25;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final vm = Provider.of<SimulationViewModel>(context, listen: false);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              color: isDark ? const Color(0xFF101622) : const Color(0xFFF6F6F8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(Icons.arrow_back,
                        color: isDark ? Colors.white70 : Colors.black87),
                  ),
                  const Spacer(),
                  Text(
                    'Configurar Simulação',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding:
                const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Temperatura (°C)',
                      style:
                      TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    TextField(
                      controller: _temperatureController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Insira a temperatura',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _selectedTemperature = int.tryParse(value) ?? 25;
                        });
                      },
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      children: _suggestedTemperatures.map((temp) {
                        return ChoiceChip(
                          label: Text('$temp°C'),
                          selected: _selectedTemperature == temp,
                          onSelected: (_) {
                            setState(() {
                              _selectedTemperature = temp;
                              _temperatureController.text = temp.toString();
                            });
                          },
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 24),
                    const Text(
                      'Dica: temperaturas mais altas geralmente aceleram reações (maior taxa k).',
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(16),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              final temp = int.tryParse(_temperatureController.text) ?? 25;
              // Gera os dados na ViewModel antes de navegar
              vm.generateSimulation(temperatureC: temp, durationSeconds: 120, pointsCount: 61);

              Navigator.of(context).push(PageRouteBuilder(
                transitionDuration: const Duration(milliseconds: 600),
                pageBuilder: (_, __, ___) => SimulatedScreen(temperature: temp),
                transitionsBuilder: (_, animation, __, child) {
                  final tween = Tween(begin: const Offset(0, 1), end: Offset.zero)
                      .chain(CurveTween(curve: Curves.easeInOut));
                  return SlideTransition(position: animation.drive(tween), child: child);
                },
              ));
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0D47A1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 16,
              ),
            ),
            child: const Text(
              'Gerar Gráfico',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
