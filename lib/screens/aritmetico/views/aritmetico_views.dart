import 'package:flutter/material.dart';

class AritmeticoView extends StatelessWidget {
  const AritmeticoView({super.key});

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
                    Navigator.pushNamed(context, "/aritmetico/valorpresente");
                  },
                  icon: const Icon(Icons.calculate),
                  label: const Text("Valor Presente"),
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
                    Navigator.pushNamed(context, "/aritmetico/valorfuturo");
                  },
                  icon: const Icon(Icons.view_timeline_rounded),
                  label: const Text("Valor Futuro"),
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
                    Navigator.pushNamed(context, "/aritmetico/valorpresenteinfinito");
                  },
                  icon: const Icon(Icons.loop_outlined),
                  label: const Text("Valor Presente G.A Infinito"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              /*const SizedBox(height: 24),
              SizedBox(
                width: 250,
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.pushNamed(context, "/aritmetico/cuotaespecifica");
                  },
                  icon: const Icon(Icons.manage_search_rounded),
                  label: const Text("Cuota Especifica"),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                    backgroundColor: const Color(0xFF232323),
                    foregroundColor: Colors.white,
                  ),
                ),
              ),*/
            ],
          ),
        ),
      ),
    );
  }
}