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


class ListaAmortizacion extends StatelessWidget {
  const ListaAmortizacion({
    super.key, required this.titulo, required this.van, required this.bSize
  });

  final String titulo;
  final List<dynamic> van;
  final double bSize;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width*0.2,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: const BoxDecoration(color: Colors.orange),
            height: MediaQuery.of(context).size.width*0.05,
            width: MediaQuery.of(context).size.width*0.2,
            child: Text(titulo,)),
          SizedBox(
            height: 300,
            child: ListView.builder(
              //scrollDirection: Axis.vertical,
              //shrinkWrap: true,
              itemCount: van.length,
              itemBuilder: (BuildContext context, int index) {
                return ListTile(title: Text("${van[index]}", style: TextStyle(fontSize: bSize), textAlign: TextAlign.center),);
              },
            ),
          ),
        ],
      ),
    );
  }
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
        decoration: const BoxDecoration(color: Color.fromARGB(0, 180, 180, 180)),
        width: double.infinity, 
        child: const Text('Tabla de UVR', textAlign: TextAlign.center,)),
       SingleChildScrollView(
        
        child: DataTable(
          columns: const [
            DataColumn(label: Text('N°')),
            DataColumn(label: Text('Fecha')),
            DataColumn(label: Text('UVR')),
          ],
          rows: List<DataRow>.generate(listaN.length, (index) {
            return DataRow(cells: [
              DataCell(Text(listaN[index].toString())),
              DataCell(Text(listaF[index])),
              DataCell(Text(listaUVR[index].toString())),
            ]);
          }),
        ),
      ),
      ]
    );
  }
}