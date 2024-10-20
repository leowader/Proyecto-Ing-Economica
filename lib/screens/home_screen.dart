import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/RetirosScreen.dart';
import 'package:ingeconomica/screens/amortizacion/view/amortizacion_view.dart';
import 'package:ingeconomica/screens/aritmetico/views/aritmetico_views.dart';
import 'package:ingeconomica/screens/bonos/views/bonos.dart';
import 'package:ingeconomica/screens/compuesto/view/compuesto_view.dart';
import 'package:ingeconomica/screens/gradiente_geometrico/view/GeometricOptionsForm.dart';
import 'package:ingeconomica/screens/inflacion/view/inflacion.dart';
import 'package:ingeconomica/screens/simple/services/interes_calculator.dart';
import 'package:ingeconomica/screens/simple/view/simple_view.dart';
import 'package:ingeconomica/screens/tir/view/tir_form.dart';


class HomeScreen extends StatefulWidget {
  final String username;
  final double initialAmount;

  const HomeScreen(
      {super.key, required this.username, required this.initialAmount});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedOptionIndex = 0; // Índice para las opciones de la lista

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedOptionIndex =
          0; // Resetear al menú principal al cambiar de sección
    });
  }

  // Ahora manejamos la navegación internamente, cambiando el índice de las opciones
  void _onOptionTapped(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final InterestCalculator calculator = InterestCalculator();

    // Incluimos todas las opciones dentro de listOptions
    List<Widget> listOptions = [
      buildMainMenu(context, calculator),
      const SimpleView(),
      const CompuestoView(),
      const GeometricOptionsForm(),
      const AritmeticoView(),
      const AmortizacionView(),
      const Bonos(), // Bonos ahora se maneja dentro del stack
      const Inflacion(), // Inflación ahora se maneja dentro del stack
      TIRView(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: [
          IndexedStack(
            index: _selectedOptionIndex,
            children: listOptions,
          ),
          buildMovimientosScreen(),
          buildServiciosScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.receipt),
            label: 'Movimientos',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view),
            label: 'Servicios',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: const Color(0xFFD6D6D6),
        unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
        backgroundColor: const Color(0xFF232323),
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }

  // Widget para la pantalla del menú principal
  Widget buildMainMenu(BuildContext context, InterestCalculator calculator) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(
          padding: EdgeInsets.all(16.0),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              Text(
                'Bienvenido, ${widget.username}',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF232323),
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'Total: \$${calculator.formatNumber(widget.initialAmount)}',
                style: const TextStyle(fontSize: 18, color: Color(0xFF232323)),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        Expanded(
          child: GridView.count(
            crossAxisCount: 3,
            mainAxisSpacing: 20,
            crossAxisSpacing: 20,
            padding: const EdgeInsets.all(20.0),
            children: [
              buildGridItem(context, "Interés Simple", Icons.attach_money, 1),
              buildGridItem(context, "Interés Compuesto", Icons.trending_up, 2),
              buildGridItem(context, "G. Geométrico", Icons.functions, 3),
              buildGridItem(context, "G. Aritmético", Icons.bar_chart, 4),
              buildGridItem(context, "Amortizacion", Icons.bar_chart, 5),
              buildGridItem(context, "Bonos", Icons.monetization_on, 6),
              buildGridItem(context, "Inflacion", Icons.monetization_on, 7),
              buildGridItem(context, "Tir", Icons.monetization_on, 8),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildMovimientosScreen() {
    return const Center(
      child: Text(
        'Pantalla de Movimientos',
        style: TextStyle(fontSize: 20),
      ),
    );
  }

  Widget buildServiciosScreen() {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const RetirosScreen()),
          );
        },
        child: const Text('Retiros'),
      ),
      ElevatedButton(
        onPressed: () {
          // Aquí podrías implementar la lógica de préstamos en el futuro
        },
        child: const Text('Préstamos'),
      ),
    ],
  );
}

  

  Widget buildGridItem(
      BuildContext context, String title, IconData icon, int optionIndex) {
    return GestureDetector(
      onTap: () {
        _onOptionTapped(optionIndex); // Cambiar la opción seleccionada
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF232323),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 30),
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 14, color: Color(0xFF232323)),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
