import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/simple/services/interes_calculator.dart';

class SimpleTiempo extends StatefulWidget {
  const SimpleTiempo({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _SimpleTiempoState createState() => _SimpleTiempoState();
}

class _SimpleTiempoState extends State<SimpleTiempo> {
  final _interesPagadoController = TextEditingController();
  final _initialCapitalController = TextEditingController();
  final _interestRateController = TextEditingController();
  double? _time;

  final InterestCalculator _calculator = InterestCalculator();

  void _calculateTime() {
    final interesPagado = double.tryParse(_interesPagadoController.text);
    final initialCapital = double.tryParse(_initialCapitalController.text);
    final interestRate = double.tryParse(_interestRateController.text);

    if (interesPagado != null &&
        initialCapital != null &&
        interestRate != null &&
        interestRate != 0) {
      final time = _calculator.calculateTime(
          interesPagado, initialCapital, interestRate);
      setState(() {
        _time = time;
      });
    } else {
      setState(() {
        _time = null;
      });
    }
  }

  /// Función para convertir el tiempo en años, meses y días
  Map<String, int> _convertTime(double timeInYears) {
    int years = timeInYears.floor();
    double remainingMonths = (timeInYears - years) * 12;
    int months = remainingMonths.floor();
    double remainingDays = (remainingMonths - months) * 30;
    int days = remainingDays.floor();

    return {
      'years': years,
      'months': months,
      'days': days,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calcular Tiempo'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildTextField(_interesPagadoController, 'Interes pagado'),
              const SizedBox(height: 24),
              _buildTextField(_initialCapitalController, 'Capital Inicial'),
              const SizedBox(height: 24),
              _buildTextField(_interestRateController, 'Tasa de Interés (%)'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateTime,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calcular Tiempo"),
                ),
              ),
              const SizedBox(height: 24),
              if (_time != null)
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
                            Icons.access_time,
                            color: Colors.white,
                            size: 26,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Center(
                              child: Column(
                                children: [
                                  Text(
                                    'Tiempo: ${_time!.toStringAsFixed(2)} años',
                                    style: const TextStyle(
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  if (_time != null)
                                    _buildTimeInYearsMonthsDays(),
                                ],
                              ),
                            ),
                          ),
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

  /// Widget para mostrar los años, meses y días
  Widget _buildTimeInYearsMonthsDays() {
    final timeComponents = _convertTime(_time!);
    return Text(
      '${timeComponents['years']} años, ${timeComponents['months']} meses, ${timeComponents['days']} días',
      style: const TextStyle(
        fontSize: 18,
        color: Colors.white,
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
