import 'package:flutter/material.dart';

class Pagos extends StatefulWidget {
  final double saldoDisponible;
  final Function(double pago, String descripcion) onPagoRealizado;

  const Pagos({super.key, required this.saldoDisponible, required this.onPagoRealizado});

  @override
  _PagosState createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  final _formKey = GlobalKey<FormState>();
  double cuota = 0.0;
  String descripcion = '';

  void _pagarCuota() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (cuota <= widget.saldoDisponible) {
        // Realiza el pago y notifica a la HomeScreen
        widget.onPagoRealizado(cuota, descripcion);

        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Pago exitoso.'),
        ));

        // Regresar a la HomeScreen
        Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Saldo insuficiente para pagar la cuota.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagar Cuota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                  'Saldo disponible: \$${widget.saldoDisponible.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 24)),
              SizedBox(height: 20),
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
              TextFormField(
                decoration: InputDecoration(labelText: 'Descripción del pago'),
                onSaved: (value) {
                  descripcion = value ?? '';
                },
              ),
              SizedBox(height: 20),
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
