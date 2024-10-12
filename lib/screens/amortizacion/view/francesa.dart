import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/amortizacion/francesa/services/calcularFrancesar.dart';

class Francesa extends StatefulWidget {
  const Francesa({super.key});

  @override
  State<Francesa> createState() => _FrancesaState();
}

class _FrancesaState extends State<Francesa> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _montoprestamo = TextEditingController();
  final TextEditingController _tasaInteresAnual = TextEditingController();
  final TextEditingController _plazoMeses = TextEditingController();

  double? _futureAmount;
  bool _knowsExactDates = true;
  String frecuenciaSeleccionada = 'Anual';
  final Map<String, int> opcionesFrecuencia = {
    'Anual': 1,
    'Semestral': 2,
    'Cuatrimestral': 3,
    'Trimestral': 4,
    'Bimestral': 6,
    'Mensual': 12
  };

  final Calcularfrancesar _calculator = Calcularfrancesar();

  void _calculateFutureAmount() {
    if (_formKey.currentState!.validate()) {
      final double montoPrestamo = double.parse(_montoprestamo.text);
      final double tasaInteresAnual = double.parse(_tasaInteresAnual.text);
      final int plazoMeses = int.parse(_plazoMeses.text);

      setState(() {
        _futureAmount = _calculator.calculateFutureAmount(
            montoPrestamo: montoPrestamo,
            plazoMeses: plazoMeses,
            tasaInteresAnual: tasaInteresAnual);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cálculo de Amortizacion Francesa"),
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
                controller: _montoprestamo,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Monto del Prestamo",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30.0),
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
              const SizedBox(height: 24),
              TextFormField(
                controller: _tasaInteresAnual,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Tasa de Interés Anual (%)",
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
              const SizedBox(height: 20),
              TextFormField(
                controller: _plazoMeses,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Ingrese el plazo en meses",
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
              const SizedBox(height: 20),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateFutureAmount,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calcular Amortizacion"),
                ),
              ),
              const SizedBox(height: 20),
              if (_futureAmount != null)
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
                              "Amortizacion: ${_calculator.formatNumber(_futureAmount!)}",
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
