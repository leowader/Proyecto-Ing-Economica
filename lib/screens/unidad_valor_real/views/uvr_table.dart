import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/unidad_valor_real/services/calculo_unidad_valor_real.dart';
import 'package:ingeconomica/screens/unidad_valor_real/views/widget.dart';

class UnidadValorRealTabla extends StatefulWidget {
  const UnidadValorRealTabla({super.key});

  @override
  UnidadValorRealTablaState createState() => UnidadValorRealTablaState();
}

class UnidadValorRealTablaState extends State<UnidadValorRealTabla> {
  final TextEditingController _valorAController = TextEditingController();
  final TextEditingController _variationController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();
  bool? _tablac = false;
  List<double> _uVRAmount = [];
  List<DateTime> _fechas = [];

  final UVRCalculator _calculator =
      UVRCalculator();


  void _calculateUVR() {
    final double valorA = double.parse(_valorAController.text);
    final double variacion = double.parse(_variationController.text);
    DateTime fInicio = _calculator.parseDate(_startDateController.text); DateTime fFinal = _calculator.parseDate(_endDateController.text);
    //final int numeroDias = fFinal.difference(fInicio).inDays;
    final int periodoCalculo = DateTime(fInicio.year,fInicio.month+1,fInicio.day).difference(fInicio).inDays;
    print(periodoCalculo);
    
      setState(() {
        _fechas = _calculator.createDates(fechaI: fInicio, periodo: periodoCalculo);
        _uVRAmount = _calculator.calculateListUVR(
          valorMoneda: valorA, 
          variacion: variacion, 
          periodoCalculo: periodoCalculo);
        _tablac = true;
      });
  }
  void _retornar(){
    setState(() {
      _uVRAmount =[];
      _tablac = false;
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
        _endDateController.text = _calculator.formatDate(DateTime(picked.year,picked.month+1,picked.day));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tabla de Unidad de Valor Real'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if(_uVRAmount.isEmpty && _tablac == false) ...[
              const SizedBox(height: 20),
              buildTextField(_valorAController, 'Unidad de Valor Real Anterior'),
              const SizedBox(height: 24),
              buildTextField(_variationController, 'Variacion (%)'),
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
                    labelText: "Fecha de Finalización",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30.0),
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
                  child: const Text("Calcular Unidad de Valor Real"),
                ),
              ),]
              else ...[
                const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: _retornar,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.all(20),
                        backgroundColor: const Color(0xFF232323),
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("Asignar otros valores"),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      decoration: BoxDecoration(border: Border.all(color: Colors.grey)),
                      width: 350,
                      height: 400,

                      child: ListView(
                        
                      
                        //width: double.infinity,
                        //height: 400,
                        children: [UVRTable(
                          listaN: _uVRAmount.map((uVRAmount) => _uVRAmount.lastIndexOf(uVRAmount)+1).toList(), 
                          listaF: _fechas.map((fecha) => _calculator.formatDate(fecha)).toList(), 
                          listaUVR: _uVRAmount),
                          ]/*Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ListaAmortizacion(titulo: 'N°', van: _uVRAmount.map((uVRAmount) => _uVRAmount.lastIndexOf(uVRAmount)+1).toList(), bSize: 10),
                            ListaAmortizacion(titulo: 'Fecha', van: _fechas.map((fecha) => _calculator.formatDate(fecha)).toList(), bSize: 10),
                            ListaAmortizacion(titulo: 'UVR', van: _uVRAmount, bSize: 10),
                          ],),*/),
                    ),
                  ],
                ),
              ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}