import 'package:flutter/material.dart';

class Inflacion extends StatefulWidget {
  const Inflacion({super.key});

  @override
  _InflacionState createState() => _InflacionState();
}

class _InflacionState extends State<Inflacion> {
  final TextEditingController _ipcInicialController = TextEditingController();
  final TextEditingController _ipcFinalController = TextEditingController();
  final TextEditingController _tasasMensualesController =
      TextEditingController();

  double _resultado = 0;
  String _tipoCalculo = 'Inflación Anual';

  void _calcular() {
    switch (_tipoCalculo) {
      case 'Inflación Anual':
        final double ipcInicial =
            double.tryParse(_ipcInicialController.text) ?? 0;
        final double ipcFinal = double.tryParse(_ipcFinalController.text) ?? 0;
        _resultado = (ipcInicial > 0 && ipcFinal > 0)
            ? ((ipcFinal - ipcInicial) / ipcInicial) * 100
            : 0;
        break;

      case 'Inflación Acumulada':
        final tasasStr = _tasasMensualesController.text
            .split(',')
            .map((e) => double.tryParse(e.trim()) ?? 0)
            .toList();
        double tasaAcumulada =
            tasasStr.fold(1, (acc, tasa) => acc * (1 + tasa / 100));
        _resultado = (tasaAcumulada - 1) * 100;
        break;

      case 'Inflación Mensual':
        final double ipcActual = double.tryParse(_ipcFinalController.text) ?? 0;
        final double ipcAnterior =
            double.tryParse(_ipcInicialController.text) ?? 0;
        _resultado = (ipcAnterior > 0 && ipcActual > 0)
            ? (((ipcActual / ipcAnterior) - 1) * 100)
            : 0;
        break;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Calculo inflacion')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            DropdownButton<String>(
              value: _tipoCalculo,
              items: <String>[
                'Inflación Anual',
                'Inflación Acumulada',
                'Inflación Mensual'
              ]
                  .map((String value) =>
                      DropdownMenuItem(value: value, child: Text(value)))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _tipoCalculo = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            if (_tipoCalculo == 'Inflación Anual') ...[
              _buildRoundedTextField(_ipcInicialController, 'IPC Inicial',
                  'Ingrese el IPC del período anterior'),
              const SizedBox(height: 10),
              _buildRoundedTextField(_ipcFinalController, 'IPC Final',
                  'Ingrese el IPC del período actual'),
            ] else if (_tipoCalculo == 'Inflación Acumulada') ...[
              _buildRoundedTextField(_tasasMensualesController,
                  'Tasas Mensuales (separadas por comas)', 'Ej: 1.5, 2.0, 1.7'),
            ] else if (_tipoCalculo == 'Inflación Mensual') ...[
              _buildRoundedTextField(_ipcInicialController, 'IPC Anterior',
                  'Ingrese el IPC del período anterior'),
              const SizedBox(height: 10),
              _buildRoundedTextField(_ipcFinalController, 'IPC Actual',
                  'Ingrese el IPC del período actual'),
            ],
            const SizedBox(height: 20),
            _buildCustomButton('Calcular', _calcular),
            const SizedBox(height: 20),
            Container(
              width: double.infinity, // Ocupa todo el ancho disponible
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Resultado',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        '${_resultado.toStringAsFixed(2)}%',
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF232323)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundedTextField(
      TextEditingController controller, String label, String hint) {
    return TextField(
      controller: controller,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(30.0)),
        labelText: label,
        hintText: hint,
      ),
    );
  }

  Widget _buildCustomButton(String text, VoidCallback onPressed) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFF232323),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      ),
      onPressed: onPressed,
      child: Text(text),
    );
  }

  @override
  void dispose() {
    _ipcInicialController.dispose();
    _ipcFinalController.dispose();
    _tasasMensualesController.dispose();
    super.dispose();
  }
}
