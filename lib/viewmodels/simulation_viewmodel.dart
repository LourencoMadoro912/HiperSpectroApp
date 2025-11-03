import 'dart:math';
import 'package:flutter/foundation.dart';
import '../models/absorbance_point.dart';
import '../services/data_service.dart';

class SimulationViewModel extends ChangeNotifier {
  List<AbsorbancePoint> _points = [];
  List<AbsorbancePoint> get points => _points;

  bool _isRunning = false;
  bool get isRunning => _isRunning;

  double get averageAbsorbance {
    if (_points.isEmpty) return 0.0;
    final sum = _points.fold<double>(0.0, (s, p) => s + p.absorbance);
    return sum / _points.length;
  }

  String get totalTime {
    if (_points.isEmpty) return '0 s';
    final last = _points.last.timeSeconds;
    if (last >= 60) {
      final minutes = (last / 60).floor();
      final seconds = (last % 60).round();
      return '${minutes}m ${seconds}s';
    } else {
      return '${last.round()} s';
    }
  }

  /// Gera dados simulados de absorbância em função do tempo para uma dada temperatura.
  /// Modelo simples: A(t) = A_inf * (1 - exp(-k * t)) + ruído, com k variando com temperatura.
  void generateSimulation({
    required int temperatureC,
    int durationSeconds = 120,
    int pointsCount = 61,
  }) {
    _isRunning = true;
    _points = [];

    // parâmetros base (pode ser ajustado)
    final random = Random(temperatureC);
    final double aInf = 1.0 + (temperatureC / 100.0); // maior temperatura -> maior absorbância final
    final double k = _kFromTemperature(temperatureC); // taxa dependente da temperatura

    for (int i = 0; i < pointsCount; i++) {
      final t = durationSeconds * (i / (pointsCount - 1));
      final noise = (random.nextDouble() - 0.5) * 0.02; // ruído pequeno
      double a = aInf * (1 - exp(-k * t)) + noise;
      if (a < 0) a = 0;
      // limite máximo razoável
      if (a > 2.5) a = 2.5;
      _points.add(AbsorbancePoint(timeSeconds: t, absorbance: a));
    }

    _isRunning = false;
    notifyListeners();
  }

  // Função que relaciona temperatura (°C) a uma constante de taxa k (1/s).
  double _kFromTemperature(int tempC) {
    // modelo simplificado: k = base * exp(beta * (T - T0))
    const base = 0.02;
    const beta = 0.04;
    const t0 = 5.0;
    final k = base * exp(beta * (tempC - t0));
    // limitar k para evitar divergências
    return k.clamp(0.0005, 0.5);
  }

  /// Persists the results using DataService.
  Future<void> saveSimulationResults(int temperature) async {
    final ds = await DataService.create();
    final runId = DateTime.now().millisecondsSinceEpoch.toString();
    await ds.saveSimulation(
      temperature: temperature,
      points: _points,
      runId: runId,
    );
  }
}
