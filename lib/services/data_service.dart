import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import '../models/absorbance_point.dart';

class DataService {
  final FirebaseFirestore? _firestore;

  // Singleton interno
  static DataService? _instance;

  DataService._(this._firestore);

  /// Factory singleton: retorna sempre a mesma instância durante a execução.
  static Future<DataService> create() async {
    if (_instance != null) return _instance!;

    try {
      final fs = FirebaseFirestore.instance;
      _instance = DataService._(fs);
      debugPrint('DataService: usando Firestore.');
    } catch (e) {
      debugPrint('DataService: Firestore não disponível: $e — usando fallback local.');
      _instance = DataService._(null);
    }

    return _instance!;
  }

  // 🔸 Fallback local cache (em memória). Mantido na instância singleton.
  final Map<String, dynamic> _localCache = {};

  /// Salva uma simulação no Firestore (se disponível) ou localmente.
  Future<void> saveSimulation({
    required int temperature,
    required List<AbsorbancePoint> points,
    required String runId,
  }) async {
    final data = {
      'temperature': temperature,
      'timestamp': DateTime.now().toIso8601String(),
      'points': points.map((p) => p.toMap()).toList(),
    };

    if (_firestore != null) {
      try {
        await _firestore!.collection('simulations').doc(runId).set(data);
        debugPrint('DataService: simulação $runId salva no Firestore.');
        return;
      } catch (e) {
        debugPrint('⚠️ Falha ao salvar no Firestore: $e — salvando localmente.');
        _localCache[runId] = data;
      }
    } else {
      // Sem Firestore, guarda localmente
      _localCache[runId] = data;
      debugPrint('💾 Simulação salva localmente: $runId');
    }
  }

  /// Obtém uma simulação local específica pelo ID
  Map<String, dynamic>? getLocalSimulation(String runId) {
    return _localCache[runId] as Map<String, dynamic>?;
  }

  /// 🔹 Retorna todas as simulações guardadas localmente (para HistoryScreen)
  List<Map<String, dynamic>> getAllLocalSimulations() {
    return _localCache.values.cast<Map<String, dynamic>>().toList();
  }

  /// Para debug: retorna o número de simulações no cache local
  int localSimulationsCount() {
    return _localCache.length;
  }

  /// Limpa o cache local (útil para testes)
  void clearLocalCache() {
    _localCache.clear();
    debugPrint('DataService: cache local limpo.');
  }
}
