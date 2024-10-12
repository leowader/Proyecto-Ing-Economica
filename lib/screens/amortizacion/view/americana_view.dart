import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/amortizacion/americana/services/calcular_americana.dart'; // Asegúrate de importar la clase

class AmericaView extends StatefulWidget {
  @override
  _AmericaViewState createState() => _AmericaViewState();
}

class _AmericaViewState extends State<AmericaView> {
  final TextEditingController principalController = TextEditingController();
  final TextEditingController tasaInteresController = TextEditingController();
  final TextEditingController aniosController = TextEditingController(); // Cambiado de años a anios

  String resultado = '';

  void calcular() {
    double principal = double.tryParse(principalController.text) ?? 0;
    double tasaInteres = double.tryParse(tasaInteresController.text) ?? 0;
    int anios = int.tryParse(aniosController.text) ?? 0; // Cambiado de años a anios

    if (principal > 0 && tasaInteres > 0 && anios > 0) {
      CalcularAmericana calculadora = CalcularAmericana(
        principal: principal,
        tasaInteresAnual: tasaInteres,
        anios: anios, // Cambiado de años a anios
      );

      Map<String, dynamic> resultadoCalculo = calculadora.calcularAmortizacion();

      setState(() {
        resultado = '''
        Pago mensual de intereses: ${resultadoCalculo['pagoInteresMensual'].toStringAsFixed(2)}
        Total de intereses pagados: ${resultadoCalculo['totalIntereses'].toStringAsFixed(2)}
        Total a pagar al final: ${resultadoCalculo['totalPago'].toStringAsFixed(2)}
        ''';
      });
    } else {
      setState(() {
        resultado = 'Por favor, ingrese valores válidos.';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Amortización Americana')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: principalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Monto del préstamo (capital)'),
            ),
            TextField(
              controller: tasaInteresController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Tasa de interés anual (%)'),
            ),
            TextField(
              controller: aniosController, // Cambiado de años a anios
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Duración del préstamo en años'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: calcular,
              child: Text('Calcular'),
            ),
            SizedBox(height: 20),
            Text(
              resultado,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
