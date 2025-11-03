import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../models/absorbance_point.dart';

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<Map<String, dynamic>> _simulations = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final ds = await DataService.create();
    setState(() {
      _simulations = ds.getAllLocalSimulations();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Histórico Local'),
        backgroundColor: const Color(0xFF0D47A1),
      ),
      body: _simulations.isEmpty
          ? const Center(child: Text('Nenhuma simulação salva localmente.'))
          : ListView.builder(
        itemCount: _simulations.length,
        itemBuilder: (context, index) {
          final sim = _simulations[index];
          final temp = sim['temperature'];
          final ts = sim['timestamp'];
          final points = (sim['points'] as List)
              .map((p) => AbsorbancePoint.fromMap(Map<String, dynamic>.from(p)))
              .toList();

          final avg = points.fold<double>(0, (s, p) => s + p.absorbance) / points.length;

          return Card(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            child: ListTile(
              leading: const Icon(Icons.science, color: Color(0xFF0D47A1)),
              title: Text('Temperatura: $temp°C'),
              subtitle: Text('Média: ${avg.toStringAsFixed(3)}  |  ${points.length} pontos'),
              trailing: Text(ts.split('T').first),
              onTap: () {
                // Mostra detalhes
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Simulação em $temp°C'),
                    content: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: points
                            .map((p) => Text('t=${p.timeSeconds.toStringAsFixed(0)}s → A=${p.absorbance.toStringAsFixed(3)}'))
                            .toList(),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Fechar'),
                      ),
                    ],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
