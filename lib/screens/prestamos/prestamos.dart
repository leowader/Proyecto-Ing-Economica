import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

class LoanWidget extends StatefulWidget {
  final Function(double) onLoanMade;

  const LoanWidget({super.key, required this.onLoanMade});

  @override
  _LoanWidgetState createState() => _LoanWidgetState();
}

class _LoanWidgetState extends State<LoanWidget> {
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _rateController = TextEditingController();
  final TextEditingController _termController = TextEditingController();

  String _loanType = "simple";
  String _amortizationType = "francesa";
  List<double> _monthlyPayments = [];
  DateTime? _endDate;

  void _calculateLoan() {
    double amount = double.tryParse(_amountController.text) ?? 0;
    double rate = (double.tryParse(_rateController.text) ?? 0) / 100;
    int term = int.tryParse(_termController.text) ?? 0;

    if (amount > 0 && rate > 0 && term > 0) {
      _monthlyPayments.clear();

      if (_loanType == "simple") {
        if (_amortizationType == "francesa") {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    "Amortización Francesa no es compatible con interés Simple")),
          );
          return;
        }
        double totalAmount = amount * (1 + rate * term);
        _monthlyPayments.add(totalAmount / (term * 12));
      } else {
        double totalAmount = amount * pow((1 + rate / 12), 12 * term);
        switch (_amortizationType) {
          case "francesa":
            double monthlyRate = rate / 12;
            int totalPayments = term * 12;
            double monthlyPayment = amount *
                monthlyRate /
                (1 - pow(1 + monthlyRate, -totalPayments));
            for (int i = 0; i < totalPayments; i++) {
              _monthlyPayments.add(monthlyPayment);
            }
            break;
          case "alemana":
            double germanBasePayment = amount / (term * 12);
            for (int i = 0; i < term * 12; i++) {
              double interestPayment =
                  (amount - (i * germanBasePayment)) * rate / 12;
              _monthlyPayments.add(germanBasePayment + interestPayment);
            }
            break;
          case "americana":
            for (int i = 0; i < term * 12; i++) {
              _monthlyPayments.add(amount * (rate / 12));
            }
            break;
        }
      }

      _endDate = DateTime.now().add(Duration(days: term * 365));
      widget.onLoanMade(amount);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Por favor, ingrese valores válidos")),
      );
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: const Text('Préstamo')),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Monto del préstamo:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _amountController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Ingrese el monto del préstamo",
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Tasa de interés (% anual):",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _rateController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Ingrese la tasa de interés",
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Plazo (años):",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              TextField(
                controller: _termController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: "Ingrese el plazo del préstamo en años",
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Tipo de interés:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Flexible(
                    child: Radio<String>(
                      value: "simple",
                      groupValue: _loanType,
                      onChanged: (String? value) {
                        setState(() {
                          _loanType = value ?? "simple";
                          if (_loanType == "simple" &&
                              _amortizationType == "francesa") {
                            _amortizationType =
                                "alemana"; // Cambia a una opción válida
                          }
                        });
                      },
                    ),
                  ),
                  const Text("Interés Simple"),
                  Flexible(
                    child: Radio<String>(
                      value: "compuesto",
                      groupValue: _loanType,
                      onChanged: (String? value) {
                        setState(() {
                          _loanType = value ?? "simple";
                        });
                      },
                    ),
                  ),
                  const Text("Interés Compuesto"),
                ],
              ),
              const SizedBox(height: 16),
              const Text(
                "Tipo de amortización:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              DropdownButton<String>(
                value: _amortizationType,
                items: <String>['francesa', 'alemana', 'americana']
                    .map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value.capitalizeFirstOfEach),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _amortizationType = newValue!;
                  });
                },
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: _calculateLoan,
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: const Color(0xFF232323), // Color del texto
                  ),
                  child: const Text("Realizar Préstamo"),
                ),
              ),
              const SizedBox(height: 20),
              if (_monthlyPayments.isNotEmpty) ...[
                const Text(
                  "Pagos mensuales:",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                Column(
                  children: _monthlyPayments.asMap().entries.map((entry) {
                    int index = entry.key;
                    double payment = entry.value;
                    return Text(
                      "Cuota ${index + 1}: \$${payment.toStringAsFixed(2)}",
                      style: const TextStyle(fontSize: 16),
                    );
                  }).toList(),
                ),
                const SizedBox(height: 10),
                Text(
                  "Fecha de finalización: ${_endDate != null ? DateFormat('dd/MM/yyyy').format(_endDate!) : ''}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

// Extensión para capitalizar el primer carácter de cada palabra
extension StringExtension on String {
  String get capitalizeFirstOfEach {
    return this.split(' ').map((word) {
      return word.length > 0
          ? '${word[0].toUpperCase()}${word.substring(1)}'
          : '';
    }).join(' ');
  }
}
