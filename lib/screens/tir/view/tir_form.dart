import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/tir/services/calcular_tir.dart';

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
  final TextEditingController _tasaInicialController = TextEditingController();
  final TextEditingController _tasaFinanciamientoController =
      TextEditingController();
  final TextEditingController _tasaReinversionController =
      TextEditingController();

  String _tipoTIR = 'Simple';
  double? _resultadoTIR;

  // Limpia los campos después de un cálculo
  void _clearFields() {
    _inversionController.clear();
    _flujosController.clear();
    _tasaInicialController.clear();
    _tasaFinanciamientoController.clear();
    _tasaReinversionController.clear();
    setState(() {
      _resultadoTIR = null;
    });
  }

  // Realiza el cálculo según el tipo de TIR seleccionado
  void _calcularTIR() {
    if (_formKey.currentState!.validate()) {
      double inversionInicial = double.parse(_inversionController.text);
      List<double> flujos = _flujosController.text
          .split(',')
          .map((f) => double.parse(f.trim()))
          .toList();
      double tasaInicial = double.parse(_tasaInicialController.text);

      if (_tipoTIR == 'Simple') {
        setState(() {
          _resultadoTIR = _tirCalculator.calcularTIRSimple(
            flujos,
            inversionInicial,
            tasaInicial,
          );
        });
      } else if (_tipoTIR == 'Modificada') {
        double tasaFinanciamiento =
            double.parse(_tasaFinanciamientoController.text);
        double tasaReinversion = double.parse(_tasaReinversionController.text);
        setState(() {
          _resultadoTIR = _tirCalculator.calcularMIRR(
            flujos,
            inversionInicial,
            tasaFinanciamiento,
            tasaReinversion,
          );
        });
      } else if (_tipoTIR == 'Incremental') {
        // Aquí puedes agregar la lógica para el cálculo incremental si tienes más campos
      }
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
                decoration: InputDecoration(
                    labelText:
                        'Flujos de caja (separados por comas, ej: 3000,4000)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese los flujos de caja';
                  }
                  return null;
                },
              ),
              // Campo para tasa inicial (para TIR simple y modificada)
              TextFormField(
                controller: _tasaInicialController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: 'Tasa Inicial (%)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la tasa inicial';
                  }
                  return null;
                },
              ),
              // Selector del tipo de TIR
              DropdownButtonFormField<String>(
                value: _tipoTIR,
                decoration: InputDecoration(labelText: 'Tipo de TIR'),
                items: ['Simple', 'Modificada', 'Incremental']
                    .map((tipo) => DropdownMenuItem(
                          value: tipo,
                          child: Text(tipo),
                        ))
                    .toList(),
                onChanged: (String? value) {
                  setState(() {
                    _tipoTIR = value!;
                  });
                },
              ),
              if (_tipoTIR == 'Modificada') ...[
                // Campos adicionales para TIR Modificada
                TextFormField(
                  controller: _tasaFinanciamientoController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Tasa de Financiamiento (%)'),
                  validator: (value) {
                    if (_tipoTIR == 'Modificada' &&
                        (value == null || value.isEmpty)) {
                      return 'Por favor ingrese la tasa de financiamiento';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _tasaReinversionController,
                  keyboardType: TextInputType.number,
                  decoration:
                      InputDecoration(labelText: 'Tasa de Reinversión (%)'),
                  validator: (value) {
                    if (_tipoTIR == 'Modificada' &&
                        (value == null || value.isEmpty)) {
                      return 'Por favor ingrese la tasa de reinversión';
                    }
                    return null;
                  },
                ),
              ],
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularTIR,
                child: Text('Calcular TIR'),
              ),
              SizedBox(height: 20),
              if (_resultadoTIR != null)
                Text(
                  'Resultado TIR: ${_resultadoTIR!.toStringAsFixed(2)}%',
                  style: TextStyle(
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
