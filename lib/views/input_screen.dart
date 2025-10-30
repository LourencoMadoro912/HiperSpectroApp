import 'package:flutter/material.dart';
import 'home_screen.dart';

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
            Container(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              color: isDark ? const Color(0xFF101622) : const Color(0xFFF6F6F8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeScreen()),
                      );
                    },
                    child: Icon(Icons.arrow_back,
                        color: isDark ? Colors.white70 : Colors.black87),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        'Configurar Simulação',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(bottom: 12),
                      child: Text(
                        'Temperatura (°C)',
                        style: TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      constraints: const BoxConstraints(maxWidth: 480),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('Valor',
                              style: TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w500)),
                          const SizedBox(height: 8),
                          TextField(
                            controller: _temperatureController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                              hintText: 'Insira a temperatura',
                              filled: true,
                              fillColor:
                              isDark ? const Color(0xFF1A1C2B) : Colors.white,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                  color: isDark
                                      ? Colors.grey.shade700
                                      : Colors.grey.shade300,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: BorderSide(
                                    color: Theme.of(context).primaryColor,
                                    width: 2),
                              ),
                              contentPadding: const EdgeInsets.all(15),
                            ),
                            style: TextStyle(
                              color: isDark ? Colors.white : Colors.black,
                              fontSize: 16,
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedTemperature =
                                    int.tryParse(value) ?? 25;
                              });
                            },
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: _suggestedTemperatures.map((temp) {
                        final isSelected = _selectedTemperature == temp;
                        return ChoiceChip(
                          label: Text('$temp°C'),
                          selected: isSelected,
                          onSelected: (_) {
                            setState(() {
                              _selectedTemperature = temp;
                              _temperatureController.text = temp.toString();
                            });
                          },
                          selectedColor: isDark
                              ? Colors.blue.withOpacity(0.3)
                              : Colors.blue.withOpacity(0.2),
                          backgroundColor: isDark
                              ? Colors.grey.shade700.withOpacity(0.8)
                              : Colors.grey.shade200,
                          labelStyle: TextStyle(
                            color: isSelected
                                ? (isDark
                                ? Colors.lightBlue[200]
                                : Colors.blue)
                                : (isDark
                                ? Colors.white70
                                : Colors.black87),
                            fontWeight: FontWeight.w500,
                          ),
                        );
                      }).toList(),
                    ),
                    const SizedBox(height: 32),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: isDark
                            ? Colors.blue.withOpacity(0.2)
                            : Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.lightbulb,
                              color: isDark
                                  ? Colors.lightBlue[200]
                                  : Colors.blue,
                              size: 28),
                          const SizedBox(width: 12),
                          const Expanded(
                            child: Text(
                              'A temperatura influencia a velocidade da reação enzimática e, portanto, a absorbância.',
                              style: TextStyle(fontSize: 14),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF101622) : const Color(0xFFF6F6F8),
          border: Border(
            top: BorderSide(
                color: isDark ? Colors.grey.shade800 : Colors.grey.shade200),
          ),
        ),
        child: SizedBox(
          width: double.infinity,
          height: 56,
          child: ElevatedButton(
            onPressed: () {
              final temp = _temperatureController.text;
              print('Gerar gráfico para $temp °C');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text(
              'Gerar Gráfico',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
        ),
      ),
    );
  }
}
