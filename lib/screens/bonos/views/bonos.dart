import 'package:flutter/material.dart';
import 'dart:math';

class Bono {
  final double valorNominal;
  final double tasaCupon;
  final double tasaRendimiento;
  final int anos;
  final int diasDevengados; 
  final int periodoCupon; 

  Bono({
    required this.valorNominal,
    required this.tasaCupon,
    required this.tasaRendimiento,
    required this.anos,
    required this.diasDevengados,
    required this.periodoCupon,
  });

  double calcularPrecio() {
    double precio = 0.0;
    double pagoCupon = valorNominal * tasaCupon;

    for (int t = 1; t <= anos * (360 / periodoCupon); t++) {
      precio += pagoCupon / pow(1 + tasaRendimiento, t * periodoCupon / 360);
    }

    precio += valorNominal / pow(1 + tasaRendimiento, anos);
    
    return precio;
  }

  double calcularPrecioSucio() {
    double precioSucio = 0.0;
    double cupon = valorNominal * tasaCupon * periodoCupon / 360;
    int totalCupones = anos * (360 ~/ periodoCupon);

    for (int i = 1; i <= totalCupones; i++) {
      precioSucio += cupon / pow(1 + tasaRendimiento, i * periodoCupon / 360);
    }

    precioSucio += valorNominal / pow(1 + tasaRendimiento, totalCupones * periodoCupon / 360);
    
    return precioSucio;
  }

  double calcularInteresDevengado() {
    double cupon = valorNominal * tasaCupon * periodoCupon / 360;
    return cupon * diasDevengados / 360;
  }

  double calcularPrecioLimpio() {
    return calcularPrecioSucio() - calcularInteresDevengado();
  }
}

class Bonos extends StatefulWidget {
  const Bonos({super.key});

  @override
  _BonosState createState() => _BonosState();
}

class _BonosState extends State<Bonos> {
  final TextEditingController _valorNominalController = TextEditingController();
  final TextEditingController _tasaCuponController = TextEditingController();
  final TextEditingController _tasaRendimientoController = TextEditingController();
  final TextEditingController _anosController = TextEditingController();
  final TextEditingController _diasDevengadosController = TextEditingController();
  final TextEditingController _periodoCuponController = TextEditingController(); 

  double _resultado = 0.0;
  String _opcionSeleccionada = 'Precio del Bono';
  final List<String> _opciones = ['Precio del Bono', 'Precio Sucio', 'Interés Devengado', 'Precio Limpio'];

  void _calcularValores() {
    final valorNominal = double.tryParse(_valorNominalController.text);
    final tasaCupon = double.tryParse(_tasaCuponController.text)! / 100;
    final tasaRendimiento = double.tryParse(_tasaRendimientoController.text)! / 100;
    final anos = int.tryParse(_anosController.text);
    final diasDevengados = int.tryParse(_diasDevengadosController.text);
    final periodoCupon = int.tryParse(_periodoCuponController.text);

    if (valorNominal != null && anos != null && diasDevengados != null && periodoCupon != null) {
      final bono = Bono(
        valorNominal: valorNominal,
        tasaCupon: tasaCupon,
        tasaRendimiento: tasaRendimiento,
        anos: anos,
        diasDevengados: diasDevengados,
        periodoCupon: periodoCupon,
      );

      setState(() {
        switch (_opcionSeleccionada) {
          case 'Precio del Bono':
            _resultado = bono.calcularPrecio();
            break;
          case 'Precio Sucio':
            _resultado = bono.calcularPrecioSucio();
            break;
          case 'Interés Devengado':
            _resultado = bono.calcularInteresDevengado();
            break;
          case 'Precio Limpio':
            _resultado = bono.calcularPrecioLimpio();
            break;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  appBar: AppBar(title: const Text('Calculo bonos')),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _valorNominalController,
              decoration: const InputDecoration(
                labelText: 'Valor Nominal del Bono () ',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tasaCuponController,
              decoration: const InputDecoration(
                labelText: 'Tasa de Cupon (%)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _tasaRendimientoController,
              decoration: const InputDecoration(
                labelText: 'Tasa de Rendimiento Requerida (%)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _anosController,
              decoration: const InputDecoration(
                labelText: 'Años hasta el Vencimiento',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _diasDevengadosController,
              decoration: const InputDecoration(
                labelText: 'Días Devengados',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _periodoCuponController,
              decoration: const InputDecoration(
                labelText: 'Periodo del Cupon (días)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _opcionSeleccionada,
              items: _opciones.map((String opcion) {
                return DropdownMenuItem<String>(
                  value: opcion,
                  child: Text(opcion),
                );
              }).toList(),
              onChanged: (String? nuevaOpcion) {
                setState(() {
                  _opcionSeleccionada = nuevaOpcion!;
                });
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _calcularValores,
              child: const Text('Calcular'),
            ),
            const SizedBox(height: 16),
            Text(
              'Resultado: ${_resultado.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
