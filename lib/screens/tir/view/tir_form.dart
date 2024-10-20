import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/tir/services/calcular_tir.dart'; // Asegúrate de que la ruta sea correcta según tu estructura de carpetas

class TIRView extends StatefulWidget {
  @override
  _TIRViewState createState() => _TIRViewState();
}

class _TIRViewState extends State<TIRView> {
  final _formKey = GlobalKey<FormState>();
  final CalcularTIR _tirCalculator = CalcularTIR();

  // Controladores para los campos de entrada
  final TextEditingController _inversionController = TextEditingController();
  final TextEditingController _flujosController = TextEditingController();

  String _metodoSeleccionado = 'Calcular TIR';
  double? _resultadoTIR;

  // Limpia los campos después de un cálculo
  void _clearFields() {
    _inversionController.clear();
    _flujosController.clear();
    setState(() {
      _resultadoTIR = null;
    });
  }

  // Realiza el cálculo según el método seleccionado
  void _calcularTIR() {
    if (_formKey.currentState!.validate()) {
      double inversionInicial = double.parse(_inversionController.text);
      List<double> flujos = _flujosController.text
          .split(',')
          .map((f) => double.parse(f.trim()))
          .toList();

      setState(() {
        if (_metodoSeleccionado == 'Calcular TIR') {
          _resultadoTIR = _tirCalculator.calcularTIR(flujos, inversionInicial);
        } else if (_metodoSeleccionado == 'Prueba y Error') {
          _resultadoTIR = _tirCalculator.calcularTIRPruebaError(flujos, inversionInicial);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de TIR'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Campo para inversión inicial
              TextFormField(
                controller: _inversionController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Inversión Inicial'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la inversión inicial';
                  }
                  return null;
                },
              ),
              // Campo para flujos de caja
              TextFormField(
                controller: _flujosController,
                keyboardType: TextInputType.text,
                decoration: const InputDecoration(
                    labelText: 'Flujos de caja (separados por comas, ej: 3000,4000)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los flujos de caja';
                  }
                  return null;
                },
              ),
              // Selector del método de cálculo
              DropdownButtonFormField<String>(
                value: _metodoSeleccionado,
                decoration: InputDecoration(labelText: 'Método de Cálculo'),
                items: ['Calcular TIR', 'Prueba y Error']
                    .map((metodo) => DropdownMenuItem(
                          value: metodo,
                          child: Text(metodo),
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _metodoSeleccionado = value!;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularTIR,
                child: Text('Calcular TIR'),
              ),
              const SizedBox(height: 20),
              if (_resultadoTIR != null)
                Text(
                  'Resultado TIR: ${_resultadoTIR!.toStringAsFixed(2)}%',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _clearFields,
                child: Text('Limpiar Campos'),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
