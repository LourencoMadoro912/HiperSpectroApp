import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fl_chart/fl_chart.dart';

import '../viewmodels/simulation_viewmodel.dart';
import '../utils/color_mapper.dart';
import 'summary_screen.dart';

class SimulatedScreen extends StatelessWidget {
  final int temperature;

  const SimulatedScreen({super.key, required this.temperature});

  @override
  Widget build(BuildContext context) {
    final vm = Provider.of<SimulationViewModel>(context);
    final points = vm.points;
    final avg = vm.averageAbsorbance;

    // Criar fl_spots a partir dos pontos
    final spots = points.map((p) => FlSpot(p.timeSeconds.toDouble(), p.absorbance)).toList();

    // define maxY para ajustar eixo Y
    final maxY = (points.isEmpty) ? 1.0 : (points.map((p) => p.absorbance).reduce((a, b) => a > b ? a : b) * 1.15).clamp(1.0, 3.0);

    final colorForAvg = ColorMapper.fromAbsorbance(avg);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gráfico - Absorbância vs Tempo'),
        backgroundColor: const Color(0xFF0D47A1),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  if (Theme.of(context).brightness == Brightness.light)
                    BoxShadow(color: Colors.black12, blurRadius: 8, offset: Offset(0, 4))
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Temperatura', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Text('$temperature °C', style: TextStyle(fontSize: 18)),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('Média de Absorbância', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Container(
                            width: 28,
                            height: 28,
                            decoration: BoxDecoration(
                              color: colorForAvg,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(color: Colors.black12),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(avg.toStringAsFixed(3)),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Theme.of(context).cardColor,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: (spots.isEmpty)
                    ? const Center(child: Text('Nenhum dado disponível.'))
                    : LineChart(
                  LineChartData(
                    minX: spots.first.x,
                    maxX: spots.last.x,
                    minY: 0,
                    maxY: maxY,
                    gridData: FlGridData(show: true),
                    titlesData: FlTitlesData(
                      leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          interval: (spots.last.x / 4).clamp(1, 60),
                          getTitlesWidget: (value, meta) {
                            // mostrar segundos ou minutos
                            if (value >= 60) {
                              final m = (value ~/ 60);
                              return Text('${m}m');
                            }
                            return Text('${value.round()}s');
                          },
                        ),
                      ),
                    ),
                    lineBarsData: [
                      LineChartBarData(
                        spots: spots,
                        isCurved: true,
                        barWidth: 3,
                        dotData: FlDotData(show: false),
                        gradient: LinearGradient(
                          colors: [colorForAvg.withOpacity(0.9), colorForAvg.withOpacity(0.4)],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        belowBarData: BarAreaData(show: true, color: colorForAvg.withOpacity(0.12)),
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () async {
                      // Salvar simulação (DataService interno)
                      await vm.saveSimulationResults(temperature);
                      // Navegar para resumo
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => SummaryScreen(
                            temperature: temperature,
                            absorbance: vm.averageAbsorbance,
                            totalTime: vm.totalTime,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 14),
                      child: Text('Salvar e Ver Resumo',
                          style: TextStyle(
                              fontSize: 16,
                              color:Colors.white
                          )
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}
