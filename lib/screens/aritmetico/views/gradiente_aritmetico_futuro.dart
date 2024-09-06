import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/aritmetico/services/calculo_gradiente_aritmetico.dart';
import 'package:ingeconomica/screens/aritmetico/views/widget.dart';

class ValorFuturo extends StatefulWidget {
  const ValorFuturo({super.key});

  @override
  _ValorFuturoState createState() => _ValorFuturoState();
}

class _ValorFuturoState extends State<ValorFuturo> {
  final TextEditingController _capitalController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _gradienteController = TextEditingController();
  final TextEditingController _daysController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  String _selectedOption = "Creciente";
  String _selectedOption2 = "Valor Futuro";
   String _selectedOption3 = "Mensual";
  String _answerText = "Valor Futuro";

  double? _futureAmount;

  final GradienteACalculator _calculator =
      GradienteACalculator();


  void _calculateFutureValue() {
      final double capital = double.parse(_capitalController.text);
      final double rate = double.parse(_rateController.text);
      final double gradient = double.parse(_gradienteController.text);
      final double year = double.parse(_yearsController.text) ;
      final double month = double.parse(_monthsController.text);
      final double day = double.parse(_daysController.text);
      final double period = _calculator.calculatePeriod(days: day, months: month, years: year, mcuota: _selectedOption3);
      final bool perfil = (_selectedOption == "Creciente")?true:false;

    if(_selectedOption2 == "Valor Futuro"){
      if (period != 0) {
        setState(() {
          _answerText= _selectedOption2;
          _futureAmount = _calculator.calculateFutureValue(
            pago: capital, 
            gradiente: gradient, 
            periodos: period, 
            interes: rate,
            perfil: perfil);
        });
      } else {
        setState(() {
          _futureAmount = null;
        });
      }
    }else{
      if (period != 0) {
        setState(() {
          _answerText= _selectedOption2;
          _futureAmount = _calculator.calculateFirtsPaymentFutureValue(
            future: capital, 
            gradiente: gradient, 
            periodos: period, 
            interes: rate,
            perfil: perfil);
        });
      } else {
        setState(() {
          _futureAmount = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Calculadora de $_selectedOption2'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
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
                    value: _selectedOption2,
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedOption2 = newValue!;
                      });
                    },
                    items: <String>[
                      'Valor Futuro',
                      'Valor Primera Cuota',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              buildTextField(_capitalController, (_selectedOption2 == "Valor Futuro")?'Valor Primera Cuota':'Valor Futuro'),
              const SizedBox(height: 24),
              buildTextField(_rateController, 'Interes (%)'),
              const SizedBox(height: 24),
              buildTextField(_gradienteController, 'Gradiente'),
              const SizedBox(height: 24),
              Row(children: [
                 Expanded(
                  child: Container(
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
                      value: _selectedOption3,
                      onChanged: (String? newValue) {
                        setState(() {
                          _selectedOption3 = newValue!;
                        });
                      },
                      items: <String>[
                        'Mensual',
                        'Anual',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                                ),
                ),
                Expanded(
                child: TextFormField(
                  controller: _daysController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Dias",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese los dias';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                child: TextFormField(
                  controller: _monthsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "Meses",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese los meses';
                    }
                    return null;
                  },
                ),
              ),
              Expanded(
                  child: TextFormField(
                  controller: _yearsController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: "años",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingrese los años';
                    }
                    return null;
                  },
                                ),
                ),
              ],),
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
                    items: <String>[
                      'Creciente',
                      'Decreciente',
                    ].map<DropdownMenuItem<String>>((String value) {
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
                  onPressed: _calculateFutureValue,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: Text("Calcular $_selectedOption2"),
                ),
              ),
              const SizedBox(height: 24),
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
                              '$_answerText: ${_futureAmount!.toStringAsFixed(2)}',
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