import 'package:flutter/material.dart';

class GeometricSeriesCalculator extends StatefulWidget {
  const GeometricSeriesCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GeometricSeriesCalculatorState createState() =>
      _GeometricSeriesCalculatorState();
}

class _GeometricSeriesCalculatorState extends State<GeometricSeriesCalculator> {
  final _valorController = TextEditingController();
  final _variacionController = TextEditingController();
  final _interesController = TextEditingController();
  final _periodosController = TextEditingController();
  
  String _valueType = 'Valor Presente'; // Default value
  String _growthType = 'Creciente'; // Default value
  double? _calculatedValue;

  void _calculateSeriesValue() {
  final double? VP_or_VF = double.tryParse(_valorController.text);
  final double? G = double.tryParse(_variacionController.text);
  final double? i = double.tryParse(_interesController.text);
  final int? n = int.tryParse(_periodosController.text);

  if (VP_or_VF != null && G != null && i != null && n != null) {

    double result = 0.0;  // Initialize result with a default value

    if (_valueType == 'Valor Presente') {
      if (_growthType == 'Creciente') {
        // Implement the reverse formula to calculate A from VP (Creciente)
        // result = calculator.calculateFromVP_Creciente(...);
      } else {
        // Implement the reverse formula to calculate A from VP (Decreciente)
        // result = calculator.calculateFromVP_Decreciente(...);
      }
    } else {
      if (_growthType == 'Creciente') {
        // Implement the reverse formula to calculate A from VF (Creciente)
        // result = calculator.calculateFromVF_Creciente(...);
      } else {
        // Implement the reverse formula to calculate A from VF (Decreciente)
        // result = calculator.calculateFromVF_Decreciente(...);
      }
    }

    setState(() {
      _calculatedValue = result;
    });
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Serie Geométrica'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Select for Valor Presente or Valor Futuro
              DropdownButton<String>(
                value: _valueType,
                items: <String>['Valor Presente', 'Valor Futuro']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _valueType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 24),
              // Select for Creciente or Decreciente
              DropdownButton<String>(
                value: _growthType,
                items: <String>['Creciente', 'Decreciente']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _growthType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 24),
              // Input fields for VP or VF, G, i, n
              _buildTextField(_valorController, _valueType),
              const SizedBox(height: 24),
              _buildTextField(_variacionController, 'Variación (G)'),
              const SizedBox(height: 24),
              _buildTextField(_interesController, 'Tasa de Interés (i)'),
              const SizedBox(height: 24),
              _buildTextField(_periodosController, 'Número de Periodos (n)'),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateSeriesValue,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calcular"),
                ),
              ),
              const SizedBox(height: 24),
              if (_calculatedValue != null)
                Text(
                  'Resultado: ${_calculatedValue!.toStringAsFixed(2)}',
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.black,
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
