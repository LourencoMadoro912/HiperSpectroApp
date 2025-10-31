import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'simulated_screen.dart';

class SimulationScreen extends StatefulWidget {
  const SimulationScreen({super.key});

  @override
  State<SimulationScreen> createState() => _SimulationScreenState();
}

class _SimulationScreenState extends State<SimulationScreen> {
  final TextEditingController _temperatureController =
  TextEditingController(text: "25");

  final List<int> _suggestedTemperatures = [25, 30, 40];
  int _selectedTemperature = 25;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // ---------- Cabeçalho ----------
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              color:
              isDark ? const Color(0xFF101622) : const Color(0xFFF6F6F8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeScreen()),
                      );
                    },
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

            // ---------- Corpo ----------
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
                    const SizedBox(height: 40),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: const [
                          Icon(Icons.lightbulb, color: Colors.blue),
                          SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'A temperatura influencia a velocidade da reação enzimática e, portanto, a absorbância.',
                            ),
                          ),
                        ],
                      ),
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
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SimulatedScreen(temperature: temp),
                ),
              );
            },
            child: const Text(
              'Gerar Gráfico',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
    );
  }
}
