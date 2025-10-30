import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:hiper_spectro/main.dart';

void main() {
  testWidgets('HomeScreen mostra logo e botão', (WidgetTester tester) async {
    // Inicializa o widget do app
    await tester.pumpWidget(HiperSpectroApp());

    // Espera o frame inicial ser construído
    await tester.pumpAndSettle();

    // Verifica se o título "Hiper Spectro" está na tela
    expect(find.text('Hiper Spectro'), findsOneWidget);

    // Verifica se o botão "Iniciar Simulação" está presente
    expect(find.text('Iniciar Simulação'), findsOneWidget);

    // Verifica se o botão é clicável
    expect(find.byType(ElevatedButton), findsOneWidget);
  });
}
