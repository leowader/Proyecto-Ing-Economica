import 'package:flutter/material.dart';

class CompuestoView extends StatelessWidget {
  const CompuestoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    Navigator.pushNamed(context, "/compuesto/montofuturo");
                  },
                  icon: const Icon(Icons.calculate),
                  label: const Text("Monto Futuro"),
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
                    Navigator.pushNamed(context, "/compuesto/tasainteres");
                  },
                  icon: const Icon(Icons.account_balance),
                  label: const Text("Tasa Interes"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: 250,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "/compuesto/tiempo");
                  },
                  icon: const Icon(Icons.access_time),
                  label: const Text("Tiempo"),
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