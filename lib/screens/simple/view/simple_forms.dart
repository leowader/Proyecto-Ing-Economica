import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/simple/services/interes_calculator.dart';

class SimpleForms extends StatefulWidget {
  const SimpleForms({super.key});

  @override
  State<SimpleForms> createState() => _SimpleFormsState();
}

class _SimpleFormsState extends State<SimpleForms> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  double? _result;
  bool _knowsExactDates = true;
  String _selectedOption = 'Monto Futuro'; // Opción seleccionada

  final InterestCalculator _calculator = InterestCalculator();

  void _calculate() {
    if (_formKey.currentState!.validate()) {
      final double capital = double.parse(_capitalController.text);
      final double rate = double.parse(_rateController.text);
      DateTime startDate;
      DateTime endDate;

      if (_knowsExactDates) {
        startDate = _calculator.parseDate(_startDateController.text);
        endDate = _calculator.parseDate(_endDateController.text);
      } else {
        final int days = int.tryParse(_daysController.text) ?? 0;
        final int months = int.tryParse(_monthsController.text) ?? 0;
        final int years = int.tryParse(_yearsController.text) ?? 0;
        startDate = DateTime.now();
        endDate =
            startDate.add(Duration(days: days + months * 30 + years * 365));
      }

      setState(() {
        if (_selectedOption == 'Monto Futuro') {
          _result = _calculator.calculateFutureAmount(
            capital: capital,
            rate: rate,
            startDate: startDate,
            endDate: endDate,
          );
        } else if (_selectedOption == 'Interés') {
          final futureAmount = _calculator.calculateFutureAmount(
            capital: capital,
            rate: rate,
            startDate: startDate,
            endDate: endDate,
          );
          _result = futureAmount -
              capital; // Interés pagado es Monto Futuro - Capital Inicial
        }
      });
    }
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
        title: const Text("Cálculo del Monto Futuro"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _capitalController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Capital Inicial",
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
              const SizedBox(height: 20),
              SwitchListTile(
                title: const Text("¿Conoce las fechas exactas del crédito?"),
                value: _knowsExactDates,
                onChanged: (bool value) {
                  setState(() {
                    _knowsExactDates = value;
                  });
                },
              ),
              const SizedBox(height: 20),
              if (_knowsExactDates) ...[
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
                    labelText: "Fecha de Finalización",
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
              ] else ...[
                TextFormField(
                  controller: _daysController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Número de Días",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _monthsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Número de Meses",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                TextFormField(
                  controller: _yearsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Número de Años",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                ),
              ],
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFFFEF7FF), 
                  borderRadius: BorderRadius.circular(30), 
                  border: Border.all(
                    color: Colors.grey, // Color del borde
                    width: 1, // Ancho del borde
                  ),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded:
                        true, // Permite que el DropdownButton ocupe todo el ancho disponible
                    value: _selectedOption,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption = newValue!;
                      });
                    },
                    items: <String>['Monto Futuro', 'Interés']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculate,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: const Color(0xFFFEF7FF),
                  ),
                  child: const Text("Calcular"),
                ),
              ),
              const SizedBox(height: 20),
              if (_result != null)
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
                                "$_selectedOption: ${_calculator.formatNumber(_result!)}",
                                style: const TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
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
