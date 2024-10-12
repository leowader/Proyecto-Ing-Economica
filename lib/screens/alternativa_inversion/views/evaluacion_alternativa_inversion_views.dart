import 'package:flutter/material.dart';

class EvaluacionAlternativaInversionView extends StatelessWidget {
  const EvaluacionAlternativaInversionView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Evaluacion de Alternativas de Inversion"),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Seleccione una opción",
                style: TextStyle(fontSize: 20), // Tamaño de la fuente del texto
              ),
              const SizedBox(
                  height: 24), // Separación entre el texto y los botones
              SizedBox(
                width: 250, // Ancho específico para todos los botones
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "/evaluacionai/vpn");
                  },
                  icon: const Icon(Icons.calculate),
                  label: const Text("VPN/IR"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    backgroundColor: const Color(0xFF232323), // Color del botón
                    foregroundColor: Colors.white, // Color del texto e íconos
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 250,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "/evaluacionai/tir");
                  },
                  icon: const Icon(Icons.view_timeline_rounded),
                  label: const Text("Tasa de Inversion de retorno"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
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