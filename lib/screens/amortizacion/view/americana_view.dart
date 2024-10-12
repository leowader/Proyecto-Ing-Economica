import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/amortizacion/americana/services/calcular_americana.dart'; // Asegúrate de importar la clase

class AmericaView extends StatefulWidget {
  const AmericaView({Key? key}) : super(key: key);

  @override
  _AmericaViewState createState() => _AmericaViewState();
}

class _AmericaViewState extends State<AmericaView> {
  final _formKey = GlobalKey<FormState>();

  // Controladores para obtener los datos ingresados por el usuario
  final TextEditingController _principalController = TextEditingController();
  final TextEditingController _tasaController = TextEditingController();
  final TextEditingController _aniosController = TextEditingController();

  // Variables para almacenar los resultados
  double? _interesMensual;
  double? _totalIntereses;
  double? _ultimoPago;

  // Función para realizar el cálculo
  void _calcularAmortizacion() {
    if (_formKey.currentState!.validate()) {
      // Obtener los valores ingresados por el usuario
      double principal = double.parse(_principalController.text);
      double tasaInteresAnual = double.parse(_tasaController.text);
      int anios = int.parse(_aniosController.text);

      // Crear una instancia de la clase CalcularAmericana
      CalcularAmericana calculadora = CalcularAmericana(
        principal: principal,
        tasaInteresAnual: tasaInteresAnual,
        anios: anios,
      );

      // Realizar el cálculo y obtener los resultados
      var resultado = calculadora.calcularAmortizacion();

      setState(() {
        _interesMensual = resultado['interesMensual'];
        _totalIntereses = resultado['totalIntereses'];
        _ultimoPago = resultado['ultimoPago'];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Amortización Americana'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _principalController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Monto del préstamo (Capital)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el monto del préstamo';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _tasaController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Tasa de interés anual (%)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la tasa de interés';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _aniosController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Duración del préstamo (años)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa la duración del préstamo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _calcularAmortizacion,
                child: const Text('Calcular'),
              ),
              const SizedBox(height: 20),
              if (_interesMensual != null) ...[
                Text('Interés mensual: ${_interesMensual!.toStringAsFixed(2)}'),
                Text('Total de intereses pagados: ${_totalIntereses!.toStringAsFixed(2)}'),
                Text('Último pago (capital + interés): ${_ultimoPago!.toStringAsFixed(2)}'),
                const SizedBox(height: 20),
              ],
            ],
          ),
        ),
      ),
    );
  }
}