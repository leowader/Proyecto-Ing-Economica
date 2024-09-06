import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/aritmetico/services/calculo_gradiente_aritmetico.dart';
import 'package:ingeconomica/screens/aritmetico/views/widget.dart';

class CuotaEspecifica extends StatefulWidget {
  const CuotaEspecifica({super.key});

  @override
  State<CuotaEspecifica> createState() => _CuotaEspecificaState();
  //_CuotaEspecificaState createState() => _CuotaEspecificaState();
}

class _CuotaEspecificaState extends State<CuotaEspecifica> {
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _gradienteController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();

  double? _specificQuota;

  final GradienteACalculator _calculator =
      GradienteACalculator();


  void _calculateFutureValue() {
      final double capital = double.parse(_capitalController.text);
      final double gradient = double.parse(_gradienteController.text);
      final double period = double.parse(_monthsController.text);

    if (period != 0) {


      setState(() {
        _specificQuota = _calculator.calculateSpecificQouta(
          pago: capital, 
          gradiente: gradient, 
          periodos: period);
      });
    } else {
      setState(() {
        _specificQuota = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Cuota Especifica'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTextField(_capitalController, 'Valor Primera Cuota'),
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
                  child: const Text("Calcular Cuota Especifica"),
                ),
              ),
              const SizedBox(height: 24),
              if (_specificQuota != null)
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
                              'Cuota Especifica: ${_specificQuota!.toStringAsFixed(2)}',
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