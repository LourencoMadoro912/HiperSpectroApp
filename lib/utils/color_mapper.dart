import 'package:flutter/material.dart';

class ColorMapper {
  /// Recebe um valor de absorbância e retorna a cor correspondente.
  /// Os limites são aproximados; ajuste conforme quiser.
  static Color fromAbsorbance(double a) {
    if (a < 0.0) return const Color(0xFFFFFF00); // default amarelo
    if (a <= 0.1) return const Color(0xFFFFF9C4); // amarelo claro (pálido)
    if (a <= 0.3) return const Color(0xFFFFF176); // amarelo forte
    if (a <= 0.5) return const Color(0xFFFFB74D); // alaranjado claro
    if (a <= 0.8) return const Color(0xFFFF8A65); // laranja
    if (a <= 1.2) return const Color(0xFF8D6E63); // marrom claro
    // valores altos -> marrom escuro
    return const Color(0xFF5D4037);
  }

  /// Fornece um hex string (opcional)
  static String hexFromAbsorbance(double a) {
    final c = fromAbsorbance(a);
    return '#${c.value.toRadixString(16).padLeft(8, '0').toUpperCase()}';
  }
}
