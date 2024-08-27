import 'package:flutter/material.dart';
import 'dart:math';

class SimpleInteres extends StatefulWidget {
  const SimpleInteres({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SimpleInteresState createState() => _SimpleInteresState();
}

class _SimpleInteresState extends State<SimpleInteres> {
  final _futureAmountController = TextEditingController();
  final _initialCapitalController = TextEditingController();
  final _timeController = TextEditingController();
  double? _interestRate;

  void _calculateInterestRate() {
    final futureAmount = double.tryParse(_futureAmountController.text);
    final initialCapital = double.tryParse(_initialCapitalController.text);
    final time = double.tryParse(_timeController.text);

    if (futureAmount != null &&
        initialCapital != null &&
        time != null &&
        time != 0) {
      final rate = (pow(futureAmount / initialCapital, 1 / time) - 1) * 100;
      setState(() {
        _interestRate = rate as double?;
      });
    } else {
      setState(() {
        _interestRate = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Tasa de Interés'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_futureAmountController, 'Monto Futuro'),
              const SizedBox(height: 24),
              _buildTextField(_initialCapitalController, 'Capital Inicial'),
              const SizedBox(height: 24),
              _buildTextField(_timeController, 'Tiempo (en años)'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateInterestRate,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calcular Tasa de Interés"),
                ),
              ),
              const SizedBox(height: 24),
              if (_interestRate != null)
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
                              'Tasa de Interés: ${_interestRate!.toStringAsFixed(2)}%',
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

  Widget _buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      keyboardType: TextInputType.number,
    );
  }
}
