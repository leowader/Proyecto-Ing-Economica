import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/aritmetico/services/calculo_gradiente_aritmetico.dart';
import 'package:ingeconomica/screens/aritmetico/views/widget.dart';

class ValorFuturo extends StatefulWidget {
  const ValorFuturo({super.key});

  @override
  _ValorFuturoState createState() => _ValorFuturoState();
}

class _ValorFuturoState extends State<ValorFuturo> {
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _gradienteController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();

  double? _futureAmount;

  final GradienteACalculator _calculator =
      GradienteACalculator();


  void _calculateFutureValue() {
      final double capital = double.parse(_capitalController.text);
      final double rate = double.parse(_rateController.text);
      final double gradient = double.parse(_gradienteController.text);
      final double period = double.parse(_monthsController.text);

    if (period != 0) {


      setState(() {
        _futureAmount = _calculator.calculateFutureValue(
          pago: capital, 
          gradiente: gradient, 
          periodos: period, 
          interes: rate);
      });
    } else {
      setState(() {
        _futureAmount = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Valor Futuro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTextField(_capitalController, 'Pago'),
              const SizedBox(height: 24),
              buildTextField(_rateController, 'Interes (%)'),
              const SizedBox(height: 24),
              buildTextField(_gradienteController, 'Gradiente'),
              const SizedBox(height: 24),
              buildTextField(_monthsController, 'Periodo'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateFutureValue,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calcular Valor Futuro"),
                ),
              ),
              const SizedBox(height: 24),
              if (_futureAmount != null)
                SizedBox(
                  width: double.infinity,
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: const Color(0xFF232323),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Icon(
                            Icons.monetization_on,
                            color: Colors.white,
                            size: 26,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Center(
                            child: Text(
                              'Tasa de Interés: ${_futureAmount!.toStringAsFixed(2)}',
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}