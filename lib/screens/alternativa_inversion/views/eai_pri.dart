import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/alternativa_inversion/services/calculo_eai.dart';
import 'package:ingeconomica/screens/aritmetico/views/widget.dart';

class EvaluacionAlternativaInversionPRIAR extends StatefulWidget {
  const EvaluacionAlternativaInversionPRIAR({super.key});

  @override
  EvaluacionAlternativaInversionPRIARState createState() => EvaluacionAlternativaInversionPRIARState();
}

class EvaluacionAlternativaInversionPRIARState extends State<EvaluacionAlternativaInversionPRIAR> {
  final TextEditingController _valorFCController = TextEditingController();
  final TextEditingController _valorIController = TextEditingController();
  double? _eAIResult;
  String _selectedOption3 = 'Mensual';
  String _anserdate = 'Mensual';
  String _answerText = 'P.R.I';
  List<double> fcaja = [];
  final EAICalculator _calculator =
      EAICalculator();

 String resultado(double invI){
    return ((fcaja.reduce((value,element) => value+element) > invI)?'P.R:I':'P.R.I(Aprox)');
  }
  void _calculateEAI() {
      final double invInicial = double.parse(_valorIController.text);
      setState(() {
        _anserdate = _selectedOption3;
        _answerText = resultado(invInicial);
        _eAIResult = _calculator.calculatePRI(
          fcaja: fcaja, 
          invInicial: invInicial, 
          tPerido: _selectedOption3);
      });
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
        title: const Text('Calculadora de Periodo de Recuperación de inversión'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 20),
              buildTextField(_valorIController, 'Inversion Inicial'),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                SizedBox(width: 300,child: buildTextField(_valorFCController, 'Flujo de caja')),
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
              const SizedBox(height: 24),
              Container(
                decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                height: 60,
                width: MediaQuery.of(context).size.width*0.6,
                child: ListView.builder(
                  itemCount: fcaja.length,
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: ObjectKey(fcaja.length-index), 
                      onDismissed: (direccion){_removeFlujoCaja(index);},
                      child: Text('${fcaja[index]}',textAlign: TextAlign.center,style: const TextStyle(fontSize: 20),),
                      );
                  },
                  ),
              ),],
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
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateEAI,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(20),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                  child: const Text("Calcular Periodo de Recuperación de inversión"),
                ),
              ),
              const SizedBox(height: 24),
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
                              '(E.A.I) $_answerText: ${_eAIResult!.toStringAsFixed(2)} ${(_anserdate == 'Mensual')?'Meses':'Años'}',
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