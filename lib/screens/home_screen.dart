import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/simple/services/interes_calculator.dart';

class HomeScreen extends StatefulWidget {
  final String username;
  final double initialAmount;

  const HomeScreen(
      {super.key, required this.username, required this.initialAmount});

  @override
  // ignore: library_private_types_in_public_api
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final InterestCalculator _calculator = InterestCalculator();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF232323), // Set AppBar color to #232323
        title: const Center(
            child: Text(
          "Menu Principal",
          style:  TextStyle(
              color: Color.fromARGB(255, 255, 255, 255)),
        )),
      ),
      body: Column(
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
                      color: Color(0xFF232323)),
                ),
                const SizedBox(height: 10),
                Text(
                  'Total: \$${_calculator.formatNumber(widget.initialAmount)}',
                  style:
                      const TextStyle(fontSize: 18, color: Color(0xFF232323)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3, // Tres columnas
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.all(20.0),
              children: [
                buildGridItem(context, "Interés Simple", Icons.attach_money,
                    "/simple"), // Icono de dinero
                buildGridItem(context, "Interés compuesto", Icons.trending_up,
                    "/compuesto"), // Icono de crecimiento
                buildGridItem(context, "G. geométrico", Icons.functions,
                    "/spaces"), // Icono de funciones matemáticas
                buildGridItem(context, "G. Aritmético", Icons.bar_chart,
                    "/people"), // Icono de gráfico de barras
                buildGridItem(context, "Préstamos", Icons.monetization_on,
                    "/option5"), // Icono de moneda
                buildGridItem(context, "Gestión de Pagos", Icons.payment,
                    "/option6"), // Icono de pago
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 5,
              blurRadius: 10,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: BottomNavigationBar(
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
            selectedItemColor: Color(0xFFD6D6D6), // Color of the active item
            unselectedItemColor:
                Color.fromARGB(255, 255, 255, 255), // Color of inactive items
            backgroundColor:
                Color(0xFF232323), // Background color for the navbar
            onTap: _onItemTapped,
            type: BottomNavigationBarType
                .fixed, // Fixed type for evenly spaced items
          ),
        ),
      ),
    );
  }

  Widget buildGridItem(
      BuildContext context, String title, IconData icon, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Color(0xFF232323), // Dark gray background for icons
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 30), // White icons
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(
                fontSize: 14, color: Color(0xFF232323)), // Dark gray text color
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
