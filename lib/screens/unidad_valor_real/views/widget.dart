import 'package:flutter/material.dart';

  Widget buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      keyboardType: TextInputType.number,
      
    );
  }

class UVRTable extends StatelessWidget {
  const UVRTable({
    super.key, required this.listaN, required this.listaF, required this.listaUVR});
    final List<dynamic> listaN;
    final List<dynamic> listaF;
    final List<dynamic> listaUVR;
    
  @override
  Widget build(BuildContext context) {
    
    return Column(
      children: [
       Container( 
        alignment: const Alignment(0,0),
        decoration: const BoxDecoration(color: Color.fromARGB(255, 196, 195, 195),border: Border(bottom: BorderSide(color: Colors.grey))),
        width: double.infinity, 
        height: 40,
        child: const Text('Tabla de UVR', textAlign: TextAlign.center,style: TextStyle(fontSize: 20),)),
       SingleChildScrollView(
        
        child: DataTable(
          columns: const [
            DataColumn(headingRowAlignment: MainAxisAlignment.center,label: Text('N°',)),
            DataColumn(headingRowAlignment: MainAxisAlignment.center,label: Text('Fecha',textAlign: TextAlign.center,)),
            DataColumn(headingRowAlignment: MainAxisAlignment.center,label: Text('UVR',textAlign: TextAlign.center,)),
          ],
          rows: List<DataRow>.generate(listaF.length, (index) {
            return DataRow(cells: [
              DataCell(Text(listaN[index].toString())),
              DataCell(Text(listaF[index])),
              DataCell(Text(listaUVR[index].toStringAsFixed(4))),
            ]);
          }),
        ),
      ),
      ]
    );
  }
}