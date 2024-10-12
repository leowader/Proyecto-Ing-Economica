import 'package:flutter/material.dart';

class GeometricOptionsForm extends StatefulWidget {
  const GeometricOptionsForm({Key? key}) : super(key: key);

  @override
  _GeometricOptionsFormState createState() => _GeometricOptionsFormState();
}

class _GeometricOptionsFormState extends State<GeometricOptionsForm> {
  int _selectedOption = 0; // 0 para "Calcular Gradiente Geométrico", 1 para "Calcular Serie"

  void _navigateToSelectedOption() {
    if (_selectedOption == 0) {
      Navigator.pushNamed(context, '/geometric/value');
    } else if (_selectedOption == 1) {
      Navigator.pushNamed(context, '/geometric/series');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seleccionar Opción'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              title: const Text('Calcular Gradiente Geométrico'),
              leading: Radio<int>(
                value: 0,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
            ),
            ListTile(
              title: const Text('Calcular Serie'),
              leading: Radio<int>(
                value: 1,
                groupValue: _selectedOption,
                onChanged: (int? value) {
                  setState(() {
                    _selectedOption = value!;
                  });
                },
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _navigateToSelectedOption,
              child: const Text('Aceptar'),
            ),
          ],
        ),
      ),
    );
  }
}
