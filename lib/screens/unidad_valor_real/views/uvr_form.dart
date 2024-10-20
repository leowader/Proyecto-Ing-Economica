import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/aritmetico/views/widget.dart';
import 'package:ingeconomica/screens/unidad_valor_real/services/calculo_unidad_valor_real.dart';

class UnidadValorReal extends StatefulWidget {
  const UnidadValorReal({super.key});

  @override
  UnidadValorRealState createState() => UnidadValorRealState();
}

class UnidadValorRealState extends State<UnidadValorReal> {
  final TextEditingController _valorAController = TextEditingController();
  final TextEditingController _variationController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final String _answerText = "Unidad de Valor Real";

  double? _uVRAmount;

  final UVRCalculator _calculator =
      UVRCalculator();


  void _calculateUVR() {
    final double valorA = double.parse(_valorAController.text);
    final double variacion = double.parse(_variationController.text);
    DateTime fInicio = _calculator.parseDate(_startDateController.text); DateTime fFinal = _calculator.parseDate(_endDateController.text);
    final int numeroDias = fFinal.difference(fInicio).inDays;
    final int periodoCalculo = DateTime(fInicio.year,fInicio.month+1,fInicio.day).difference(fInicio).inDays;
    //final int periodoCalculo = int.parse(_timeOption);
    print(periodoCalculo);
    
      setState(() {
        _uVRAmount = _calculator.calculateUVR(
          valorMoneda: valorA, 
          variacion: variacion, 
          numDias: numeroDias, 
          periodoCalculo: periodoCalculo);
      });
  }

   Future<void> _selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        controller.text = _calculator.formatDate(picked);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Unidad de Valor Real'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              buildTextField(_valorAController, 'Unidad de Valor Real Anterior'),
              const SizedBox(height: 24),
              buildTextField(_variationController, 'Variacion del IPC(%)'),
              const SizedBox(height: 24),
              TextFormField(
                  controller: _startDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Fecha de Inicio",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () =>
                          _selectDate(context, _startDateController),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la fecha de inicio';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _endDateController,
                  readOnly: true,
                  decoration: InputDecoration(
                    labelText: "Fecha de Calculo",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context, _endDateController),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese la fecha de finalización';
                    }
                    return null;
                  },
                ),             
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateUVR,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calcular Unidad Valor Real"),
                ),
              ),
              const SizedBox(height: 24),
              if (_uVRAmount != null)
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
                              '$_answerText: ${_uVRAmount!.toStringAsFixed(4)}',
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