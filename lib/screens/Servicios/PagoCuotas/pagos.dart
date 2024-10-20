import 'package:flutter/material.dart';

class Pagos extends StatefulWidget {
  @override
  _PagosState createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  final _formKey = GlobalKey<FormState>();
  double saldo =
      2000000; // Saldo inicial local (puede venir de una base de datos)
  double cuota = 0.0; // Monto de la cuota a pagar ingresado por el usuario

  // Función para procesar el pago de la cuota
  void _pagarCuota() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Guarda el valor ingresado por el usuario

      if (cuota <= saldo) {
        // Si el saldo es suficiente, restar el valor de la cuota
        setState(() {
          saldo -= cuota;
        });

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              'Pago exitoso. Saldo restante: \$${saldo.toStringAsFixed(2)}'),
        ));
      } else {
        // Si el saldo es insuficiente, mostrar un mensaje de error
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('Saldo insuficiente para pagar la cuota.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pagar Cuota'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Muestra el saldo disponible localmente
              Text(
                'Saldo disponible: \$${saldo.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 24),
              ),
              SizedBox(height: 20),
              // Campo para ingresar el monto de la cuota
              TextFormField(
                decoration: InputDecoration(labelText: 'Cuota a pagar'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, ingresa un número válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  cuota = double.parse(value!);
                },
              ),
              SizedBox(height: 20),
              // Botón para realizar el pago
              ElevatedButton(
                onPressed: _pagarCuota,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: const Color(0xFF232323),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Pagar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
