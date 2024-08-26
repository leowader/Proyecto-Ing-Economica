import 'package:flutter/material.dart';

class SimpleForms extends StatefulWidget {
  const SimpleForms({super.key});

  @override
  State<SimpleForms> createState() => _SimpleFormsState();
}

class _SimpleFormsState extends State<SimpleForms> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();
  double? _futureAmount;

  void _calculateFutureAmount() {
    if (_formKey.currentState!.validate()) {
      final double capital = double.parse(_capitalController.text);
      final double rate = double.parse(_rateController.text);
      final double time = double.parse(_timeController.text);

      setState(() {
        _futureAmount = capital * (1 + (rate / 100) * time);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cálculo del Monto Futuro"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: _capitalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Capital Inicial",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Borde redondeado
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el capital inicial';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Tasa de Interés (%)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Borde redondeado
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese la tasa de interés';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              TextFormField(
                controller: _timeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Tiempo (en años)",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0), // Borde redondeado
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el tiempo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _calculateFutureAmount,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  backgroundColor: const Color(0xFF232323),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Calcular Monto Futuro"),
              ),
              const SizedBox(height: 24),
              if (_futureAmount != null)
                Text(
                  "Monto Futuro: \$${_futureAmount!.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
