import 'package:flutter/material.dart';

class HistorialPagos extends StatelessWidget {
  const HistorialPagos({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> historialPagos = [
      {"monto": 150000, "fecha": "20/10/2024"}
    ];
    return Scaffold(
      appBar: AppBar(
        title: Text('Historial de Pagos'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: historialPagos.isEmpty
            ? Center(child: Text('No hay pagos realizados.'))
            : ListView.builder(
                itemCount: historialPagos.length,
                itemBuilder: (context, index) {
                  final pago = historialPagos[index];
                  final monto = pago['monto'];
                  final fecha = pago['fecha'];

                  return ListTile(
                    leading: Icon(Icons.payment),
                    title: Text('Monto: \$${monto.toStringAsFixed(2)}'),
                    subtitle: Text('Fecha: $fecha'),
                  );
                },
              ),
      ),
    );
  }
}
