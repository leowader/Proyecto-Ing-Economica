import 'package:flutter/material.dart';

class ListaPrestamos extends StatelessWidget {
  // Esta sería la lista de préstamos que podrías obtener del backend o la base de datos
  final List<Map<String, dynamic>> loans = [
    {'amount': 5000, 'term': 12, 'balance': 4800},
    {'amount': 10000, 'term': 24, 'balance': 9500},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Préstamos Activos'),
      ),
      body: ListView.builder(
        itemCount: loans.length,
        itemBuilder: (context, index) {
          final loan = loans[index];
          return ListTile(
            title: Text('Monto: \$${loan['amount']}'),
            subtitle: Text(
                'Plazo: ${loan['term']} meses, Saldo: \$${loan['balance']}'),
          );
        },
      ),
    );
  }
}
