import 'package:flutter/material.dart';
import '../services/geometric_gradient_calculator.dart';

class GeometricValueCalculator extends StatefulWidget {
  const GeometricValueCalculator({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _GeometricValueCalculatorState createState() =>
      _GeometricValueCalculatorState();
}

class _GeometricValueCalculatorState extends State<GeometricValueCalculator> {
  final _seriePagosController = TextEditingController();
  final _variacionController = TextEditingController();
  final _interesController = TextEditingController();
  final _periodosController = TextEditingController();

  String _valueType = 'Valor Presente'; // Default value
  String _growthType = 'Creciente'; // Default value
  double? _calculatedValue;

  void _calculateValue() {
    final double? A = double.tryParse(_seriePagosController.text);
    final double? G = double.tryParse(_variacionController.text);
    final double? i = double.tryParse(_interesController.text);
    final int? n = int.tryParse(_periodosController.text);

    // Verifica si alguna entrada no es válida
    if (A == null || G == null || i == null || n == null) {
      setState(() {
        _calculatedValue = null; // No mostrar resultado si hay un error
      });
      // Muestra un mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, ingresa valores válidos.'),
        ),
      );
      return;
    }

    final calculator = GeometricGradientCalculator();
    double result;

    if (_valueType == 'Valor Presente') {
      if (_growthType == 'Creciente') {
        result =
            calculator.calculateValorPresenteCreciente(A: A, G: G, i: i, n: n);
      } else {
        result = calculator.calculateValorPresenteDecreciente(
            A: A, G: G, i: i, n: n);
      }
    } else {
      if (_growthType == 'Creciente') {
        result =
            calculator.calculateValorFuturoCreciente(A: A, G: G, i: i, n: n);
      } else {
        result =
            calculator.calculateValorFuturoDecreciente(A: A, G: G, i: i, n: n);
      }
    }

    setState(() {
      _calculatedValue = result;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Valor Geométrico'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Select for Valor Presente or Valor Futuro
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF7FF),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey, // Color del borde
                    width: 1, // Ancho del borde
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded:
                        true, // Permite que el DropdownButton ocupe todo el ancho disponible
                    value: _valueType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _valueType = newValue!;
                      });
                    },
                    items: <String>['Valor Presente', 'Valor Futuro']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Select for Creciente or Decreciente
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF7FF),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(
                    color: Colors.grey, // Color del borde
                    width: 1, // Ancho del borde
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded:
                        true, // Permite que el DropdownButton ocupe todo el ancho disponible
                    value: _growthType,
                    onChanged: (String? newValue) {
                      setState(() {
                        _growthType = newValue!;
                      });
                    },
                    items: <String>['Creciente', 'Decreciente']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Input fields for A, G, i, n
              _buildTextField(_seriePagosController, 'Serie de Pagos (A)'),
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
                  onPressed: _calculateValue,
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
