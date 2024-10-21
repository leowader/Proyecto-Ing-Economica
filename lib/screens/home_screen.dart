import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/RetirosScreen.dart';
import 'package:ingeconomica/screens/alternativa_inversion/views/evaluacion_alternativa_inversion_views.dart';
import 'package:ingeconomica/screens/pagos/pagos.dart';
import 'package:ingeconomica/screens/prestamos/prestamos.dart';
import 'package:ingeconomica/screens/unidad_valor_real/views/unidad_valor_real_views.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  const HomeScreen({
    super.key,
    required this.username,
    required this.initialAmount,
  });

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  int _selectedOptionIndex = 0; // Index for the option list
  double currentAmount = 0;
  List<String> transactions = [];

  @override
  void initState() {
    super.initState();
    loadAmount();
    loadTransactions();
  }

  Future<void> loadAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      currentAmount = prefs.getDouble('amount') ?? widget.initialAmount;
    });
  }

  Future<void> saveAmount() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('amount', currentAmount);
  }

  Future<void> loadTransactions() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      transactions = prefs.getStringList('transactions') ?? [];
    });
  }

  Future<void> saveTransaction(String transaction) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    transactions.add(transaction);
    await prefs.setStringList('transactions', transactions);
  }

  void makeLoan(double amount) {
    setState(() {
      currentAmount += amount;
      saveAmount();
      saveTransaction('Préstamo de \$${amount.toStringAsFixed(2)}');
    });
  }

  void makePayment(double amount) {
    setState(() {
      currentAmount -= amount;
      saveAmount();
      saveTransaction('Pago de \$${amount.toStringAsFixed(2)}');
    });

    // Mostrar un SnackBar con la notificación del pago realizado
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content:
            Text('Se ha realizado un pago de \$${amount.toStringAsFixed(2)}'),
        duration: const Duration(seconds: 3), // Duración de la notificación
        action: SnackBarAction(
          label: 'OK',
          onPressed: () {
            // Acción opcional para el botón de 'OK' en el SnackBar
          },
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      _selectedOptionIndex = 0; // Reset to main menu when changing sections
    });
  }

  void _onOptionTapped(int index) {
    setState(() {
      _selectedOptionIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final InterestCalculator calculator = InterestCalculator();

    List<Widget> listOptions = [
      buildMainMenu(context, calculator),
      const SimpleView(),
      const CompuestoView(),
      const GeometricOptionsForm(),
      const AritmeticoView(),
      const AmortizacionView(),
      const Bonos(),
      const Inflacion(),
      TIRView(),
      const UnidadValorRealView(),
      const EvaluacionAlternativaInversionView(),
    ];

    return WillPopScope(
      onWillPop: () async {
        if (_selectedOptionIndex != 0) {
          setState(() {
            _selectedOptionIndex = 0; // Go back to main menu
          });
          return false; // Don't leave the current screen
        }
        return true; // Allow the system to handle the back button
      },
      child: Scaffold(
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
          unselectedItemColor: const Color(0xFFFFFFFF),
          backgroundColor: const Color(0xFF232323),
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  Widget buildMainMenu(BuildContext context, InterestCalculator calculator) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const SizedBox(height: 10),
          buildBalanceCard(calculator),
          const SizedBox(height: 20),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              padding: const EdgeInsets.all(20.0),
              children: [
                buildGridItem(context, "I. Simple", Icons.money, 1),
                buildGridItem(
                    context, "I. Compuesto", Icons.trending_up, 2),
                buildGridItem(context, "G. Geométrico", Icons.pie_chart, 3),
                buildGridItem(context, "G. Aritmético", Icons.calculate, 4),
                buildGridItem(context, "Amortización", Icons.history, 5),
                buildGridItem(context, "Bonos", Icons.attach_money, 6),
                buildGridItem(context, "Inflación", Icons.trending_down, 7),
                buildGridItem(context, "TIR", Icons.trending_up, 8),
                buildGridItem(
                    context, "U.V.R", Icons.monetization_on_outlined, 9),
                buildGridItem(
                    context, "E.A.I", Icons.account_balance_outlined, 10),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildBalanceCard(InterestCalculator calculator) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Colors.blueAccent, Colors.lightBlueAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Icon(Icons.account_balance_wallet,
                size: 40, color: Colors.white),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '\$${calculator.formatNumber(currentAmount)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

Widget buildMovimientosScreen() {
  return Padding(
    padding: const EdgeInsets.all(30.0),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Historial de Movimientos',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              String transaction = transactions[index];

              // Usar la expresión regular para encontrar el número
              RegExp regExp = RegExp(r'(\d+\.?\d*)');
              Match? match = regExp.firstMatch(transaction);

              if (match != null) {
                String amountString = match.group(0)!;
                double amount = double.parse(amountString);

                // Asignar tipo de transacción (préstamo o pago)
                String transactionType =
                    transaction.split(' ')[0]; // Obtener tipo

                // Definir colores según el tipo de transacción
                Color tileColor = transactionType == 'Préstamo'
                    ? Colors.green[100]!
                    : Colors.red[100]!;
                Color textColor =
                    transactionType == 'Préstamo' ? Colors.green : Colors.red;

                // Formatear monto para mostrar sin decimales
                String formattedAmount = amount.toStringAsFixed(0);

                return Card(
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    title: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '$transactionType de \$',
                            style: const TextStyle(
                                fontSize: 16, color: Colors.black),
                          ),
                          TextSpan(
                            text: formattedAmount,
                            style: TextStyle(fontSize: 16, color: textColor),
                          ),
                        ],
                      ),
                    ),
                    leading: const Icon(Icons.receipt),
                    tileColor: tileColor,
                  ),
                );
              } else {
                // Manejar si no se encuentra un número válido
                return ListTile(
                  title: Text('Transacción inválida'),
                );
              }
            },
          ),
        ),
      ],
    ),
  );
}

 // Inside the HomeScreen, update the buildServiciosScreen method to include the callback:

Widget buildServiciosScreen() {
  return Padding(
    padding: const EdgeInsets.all(16.0),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Servicios Disponibles',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          buildServiceCard('Hacer Préstamo', Icons.monetization_on, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoanWidget(
                  onLoanMade: (double loanAmount) {
                    makeLoan(loanAmount);
                  },
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          buildServiceCard('Hacer Pago', Icons.payment, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Pagos(
                  saldoDisponible: currentAmount,
                  onPagoRealizado: (double pago, String descripcion) {
                    makePayment(pago);
                    saveTransaction(
                        'Pago de \$${pago.toStringAsFixed(2)}: $descripcion');
                  },
                ),
              ),
            );
          }),
          const SizedBox(height: 16),
          buildServiceCard('Retiros', Icons.attach_money, () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => RetirosScreen(
                  onRetiroRealizado: (double retiroAmount) {
                    setState(() {
                      currentAmount -= retiroAmount; // Deduct amount
                      saveAmount(); // Save new balance
                      saveTransaction(
                          'Retiro de \$${retiroAmount.toStringAsFixed(2)}');
                    });
                  },
                ),
              ),
            );
          }),
        ],
      ),
    ),
  );
}

  Widget buildServiceCard(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        leading: Icon(icon),
        trailing: const Icon(Icons.arrow_forward),
        onTap: onTap,
      ),
    );
  }

  Widget buildGridItem(
      BuildContext context, String title, IconData icon, int optionIndex) {
    return GestureDetector(
      onTap: () {
        _onOptionTapped(optionIndex); // Change selected option
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
