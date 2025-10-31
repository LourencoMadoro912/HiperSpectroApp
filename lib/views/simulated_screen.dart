import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class SimulatedScreen extends StatelessWidget {
  final int temperature;

  const SimulatedScreen({super.key, required this.temperature});

  /// Gera dados de curva de absorbância conforme a temperatura
  List<FlSpot> _generateData(double factor) {
    return List.generate(11, (i) {
      final x = i.toDouble();
      final y = (1.2 - (x * factor)).clamp(0, 1.2).toDouble();
      return FlSpot(x, y);
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;

    return Scaffold(
      backgroundColor:
      isDark ? const Color(0xFF101622) : const Color(0xFFF6F6F8),
      appBar: AppBar(
        backgroundColor:
        isDark ? const Color(0xFF101622) : const Color(0xFFF6F6F8),
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,
              color: isDark ? Colors.white70 : Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        centerTitle: true,
        title: Text(
          "Simulação em Tempo Real",
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline,
                color: isDark ? Colors.white70 : Colors.black87),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // ---------- Gráfico ----------
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isDark ? Colors.grey[850] : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  if (!isDark)
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Absorbância vs Tempo",
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 250,
                    child: LineChart(
                      LineChartData(
                        minX: 0,
                        maxX: 10,
                        minY: 0,
                        maxY: 1.2,
                        gridData: FlGridData(
                          show: true,
                          drawVerticalLine: true,
                          horizontalInterval: 0.3,
                          verticalInterval: 2,
                          getDrawingHorizontalLine: (value) => FlLine(
                            color: isDark
                                ? Colors.grey[700]
                                : Colors.grey[300],
                            strokeWidth: 1,
                          ),
                          getDrawingVerticalLine: (value) => FlLine(
                            color: isDark
                                ? Colors.grey[700]
                                : Colors.grey[300],
                            strokeWidth: 1,
                          ),
                        ),
                        titlesData: FlTitlesData(
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                              interval: 0.3,
                              getTitlesWidget: (value, _) => Text(
                                value.toStringAsFixed(1),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              interval: 2,
                              getTitlesWidget: (value, _) => Text(
                                value.toInt().toString(),
                                style: TextStyle(
                                  color: Colors.grey[500],
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                        borderData: FlBorderData(show: false),
                        lineBarsData: [
                          LineChartBarData(
                            spots: _generateData(0.12),
                            isCurved: true,
                            color: Colors.red,
                            barWidth: 2,
                            dotData: const FlDotData(show: false),
                          ),
                          LineChartBarData(
                            spots: _generateData(0.09),
                            isCurved: true,
                            color: Colors.orange,
                            barWidth: 2,
                            dotData: const FlDotData(show: false),
                          ),
                          LineChartBarData(
                            spots: _generateData(0.06),
                            isCurved: true,
                            color: Colors.blue,
                            barWidth: 2,
                            dotData: const FlDotData(show: false),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Center(
                    child: Text(
                      "Tempo (minutos)",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: 13,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    alignment: WrapAlignment.center,
                    spacing: 20,
                    runSpacing: 8,
                    children: const [
                      _LegendItem(color: Colors.blue, label: "25 °C"),
                      _LegendItem(color: Colors.orange, label: "30 °C"),
                      _LegendItem(color: Colors.red, label: "40 °C"),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ---------- Cor simulada ----------
            Column(
              children: [
                Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(maxWidth: 400),
                  height: 130,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFFFFF9C4),
                        Color(0xFFFFB74D),
                        Color(0xFF5D4037),
                      ],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      )
                    ],
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      width: 6,
                      margin: const EdgeInsets.only(left: 110),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(999),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Cor simulada da amostra",
                  style: TextStyle(
                    color: Colors.grey[500],
                    fontSize: 13,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // ---------- Botão ----------
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF135BEC),
                  shape: const StadiumBorder(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 16,
                  ),
                ),
                child: const Text(
                  "Ver Resultados",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(999),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            color: isDark ? Colors.grey[300] : Colors.grey[700],
            fontSize: 14,
          ),
        ),
      ],
    );
  }
}
