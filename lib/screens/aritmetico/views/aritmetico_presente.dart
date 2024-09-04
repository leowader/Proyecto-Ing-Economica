import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/aritmetico/services/calculo_gradiente_aritmetico.dart';

class ValorPresente extends StatefulWidget {
  const ValorPresente({super.key});

  @override
  State<ValorPresente> createState() => _ValorPresenteState();
}

class _ValorPresenteState extends State<ValorPresente> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _gradienteController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();

  double? _presentAmount;


  final GradienteACalculator _calculator =
      GradienteACalculator(); // Instanciamos la clase de lógica.

  void _calculatePresentValue() {
    if (_formKey.currentState!.validate()) {
      final double capital = double.parse(_capitalController.text);
      final double rate = double.parse(_rateController.text);
      final double gradient = double.parse(_gradienteController.text);
      final double period = double.parse(_monthsController.text);


      setState(() {
        _presentAmount = _calculator.calculatePresentValue(
          pago: capital, 
          gradiente: gradient, 
          periodos: period, 
          interes: rate);
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cálculo del Valor Presente"),
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
                  labelText: "Pago",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el pago';
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
                    borderRadius: BorderRadius.circular(30.0),
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
                controller: _gradienteController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Gradiente",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el gradiente';
                  }
                  return null;
                },
              ),
                            const SizedBox(height: 24),
              TextFormField(
                controller: _monthsController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Periodo",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor ingrese el periodo';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculatePresentValue,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calcular Valor Presente"),
                ),
              ),
              const SizedBox(height: 20),
              if (_presentAmount != null)

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
                            Icons.monetization_on,
                            color: Colors.white,
                            size: 26,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                              child: Center(
                            child: Text(
                              "Valor Presente: ${_calculator.formatNumber(_presentAmount!)}",
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          )),
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
}