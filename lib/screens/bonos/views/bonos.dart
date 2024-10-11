import 'package:flutter/material.dart';
import 'dart:math';

class Bono {
  final double valorNominal;
  final double tasaCupon;
  final double tasaRendimiento;
  final int anos;
  final int diasDevengados; // Agregado para el interés devengado
  final int periodoCupon; // Periodo de pago del cupon en días

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

    // Agregar el valor nominal descontado al final del período
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
  final TextEditingController _periodoCuponController = TextEditingController(); // Período del cupon
  
  double _precioBono = 0.0;
  double _precioSucio = 0.0;
  double _interesDevengado = 0.0;
  double _precioLimpio = 0.0;

  void _calcularValores() {
    final valorNominal = double.tryParse(_valorNominalController.text);
    final tasaCupon = double.tryParse(_tasaCuponController.text)! / 100; // Convertir a decimal
    final tasaRendimiento = double.tryParse(_tasaRendimientoController.text)! / 100; // Convertir a decimal
    final anos = int.tryParse(_anosController.text);
    final diasDevengados = int.tryParse(_diasDevengadosController.text);
    final periodoCupon = int.tryParse(_periodoCuponController.text); // Periodo del cupon en días

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
        _precioBono = bono.calcularPrecio();
        _precioSucio = bono.calcularPrecioSucio();
        _interesDevengado = bono.calcularInteresDevengado();
        _precioLimpio = bono.calcularPrecioLimpio();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cálculo de Bonos'),
      ),
      body: SingleChildScrollView( // Agregado para hacer la vista scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextField(
              controller: _valorNominalController,
              decoration: const InputDecoration(
                labelText: 'Valor Nominal del Bono (£)',
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
            ElevatedButton(
              onPressed: _calcularValores,
              child: const Text('Calcular Valores del Bono'),
            ),
            const SizedBox(height: 16),
            Text(
              'Precio del Bono: £${_precioBono.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Precio Sucio: £${_precioSucio.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Interés Devengado: £${_interesDevengado.toStringAsFixed(2)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Precio Limpio: £${_precioLimpio.toStringAsFixed(2)}',
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
