import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/alternativa_inversion/services/calculo_eai.dart';
import 'package:ingeconomica/screens/aritmetico/views/widget.dart';

class EvaluacionAlternativaInversionTIR extends StatefulWidget {
  const EvaluacionAlternativaInversionTIR({super.key});

  @override
  EvaluacionAlternativaInversionTIRState createState() => EvaluacionAlternativaInversionTIRState();
}

class EvaluacionAlternativaInversionTIRState extends State<EvaluacionAlternativaInversionTIR> {
  final TextEditingController _valorFCController = TextEditingController();
  final TextEditingController _valorIController = TextEditingController();
  final TextEditingController _tasaDController = TextEditingController();
  final TextEditingController _tasaD2Controller = TextEditingController();
    final TextEditingController _daysController = TextEditingController();
  final TextEditingController _monthsController = TextEditingController();
  final TextEditingController _yearsController = TextEditingController();
  double? _eAIResult;
  String? _selectedOption2= "Prueba y Error";
  String _selectedOption3 = "Mensual";
  List<double> fcaja = [];
  final EAICalculator _calculator =
      EAICalculator();


  void _calculateTIR() {
    final double invInicial = double.parse(_valorIController.text);

    if(_selectedOption2 == 'Prueba y Error'){
      final double tasadescuento = double.parse(_tasaDController.text);
      setState(() {
        _eAIResult = _calculator.calculateTIRPE(
          flcaja: fcaja, 
          tasadescuento: tasadescuento, 
          invInicial: invInicial);
      });
    } else if(_selectedOption2 == 'Interpolación Lineal'){
      final double tasadescuento = double.parse(_tasaDController.text);
      final double tasadescuento2 = double.parse(_tasaD2Controller.text);
      setState(() {
        _eAIResult = _calculator.calculateTIRIL(
          fcaja: fcaja, 
          tasadescuento: tasadescuento, 
          tasadescuento2: tasadescuento2, 
          invInicial: invInicial);
      });
    }else{
      final double fcajaUnico = double.parse(_valorFCController.text);
      final double years = double.parse(_yearsController.text) ;
      final double months = double.parse(_monthsController.text);
      final double days = double.parse(_daysController.text);
      final double periodo = _calculator.calculatePeriod(days: days, months: months, years: years, mcuota: _selectedOption3);
      setState(() {
        _eAIResult = _calculator.calculateTIRA(
          cajaUnico: fcajaUnico, 
          invInicial: invInicial, 
          periodo: periodo);
      });
    }
  }

  void _addFlujoCaja(){
    if(_valorFCController.text.isNotEmpty && double.parse(_valorFCController.text) > 0){
      setState(() {
        fcaja.add(double.parse(_valorFCController.text));
        _valorFCController.text="";
      });
      print(fcaja);
    }
  }

  void _removeFlujoCaja(int caja){
    setState(() {
      fcaja.removeAt(caja);
    });
    print(fcaja);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calculadora de Tasa de Inversion de Retorno',style: TextStyle(fontSize: 20), textAlign: TextAlign.center,),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
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
                      'Prueba y Error',
                      'Interpolación Lineal',
                      'Analitico',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              if(_selectedOption2 != 'Analitico')...[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width*0.7,
                    child: buildTextField(_valorFCController, 'Flujo de caja')),
                  SizedBox(
                  child: ElevatedButton(
                    onPressed: _addFlujoCaja,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(20),
                      backgroundColor: const Color(0xFF232323),
                      foregroundColor: Colors.white,
                    ),
                    child: const Text("Añandir FC"),
                  ),
                ),
                ],),
                if (fcaja.isNotEmpty) ... [
                const SizedBox(height: 12),
                Container(
                  decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                  height: 40,
                  width: MediaQuery.of(context).size.width*0.6,
                  child: ListView.builder(
                    itemCount: fcaja.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: ObjectKey(fcaja.length-index), 
                        onDismissed: (direccion){_removeFlujoCaja(index);},
                        child: Text('${fcaja[index]}'),
                        );
                    },
                    ),
                ),],
                const SizedBox(height: 20),
                buildTextField(_valorIController, 'Inversion Inicial'),
                const SizedBox(height: 20),
                if(_selectedOption2 == 'Interpolación Lineal')...[
                  buildTextField(_tasaDController, 'Tasa de descuento1 (%)'),
                  const SizedBox(height: 20),
                  buildTextField(_tasaD2Controller, 'Tasa de descuento2 (%)'),
                  const SizedBox(height: 20),
                ]else...[
                  buildTextField(_tasaDController, 'Tasa de descuento (%)'),
                  const SizedBox(height: 20),],
              ]else...[
                buildTextField(_valorFCController, 'Flujo de Caja Unico'),
                const SizedBox(height: 24),
                buildTextField(_valorIController, 'Inversion Inicial'),
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
                const SizedBox(height: 20),
              ],
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateTIR,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calcular T.I.R"),
                ),
              ),
              const SizedBox(height: 20),
              if (_eAIResult != null)
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
                              '(E.A.I) T.I.R: ${_eAIResult!.toStringAsFixed(2)}%',
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