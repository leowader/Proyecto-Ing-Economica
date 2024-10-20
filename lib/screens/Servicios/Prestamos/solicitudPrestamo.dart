import 'package:flutter/material.dart';

class solicitudPrestamo extends StatefulWidget {
  @override
  _solicitudPrestamoState createState() => _solicitudPrestamoState();
}

class _solicitudPrestamoState extends State<solicitudPrestamo> {
  final _formKey = GlobalKey<FormState>();
  double loanAmount = 0.0;
  int loanTerm = 0;

  // Función para solicitar el préstamo
  void _submitLoanRequest() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Aquí puedes agregar lógica para enviar la solicitud de préstamo al backend
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(
            'Solicitud de préstamo enviada: \$${loanAmount.toStringAsFixed(2)} a ${loanTerm} meses'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Solicitar Préstamo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(labelText: 'Monto del préstamo'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor ingresa un valor numérico';
                  }
                  return null;
                },
                onSaved: (value) {
                  loanAmount = double.parse(value!);
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Plazo (meses)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingresa el plazo';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Por favor ingresa un número entero';
                  }
                  return null;
                },
                onSaved: (value) {
                  loanTerm = int.parse(value!);
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitLoanRequest,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: const Color(0xFF232323),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Solicitar prestamo"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
