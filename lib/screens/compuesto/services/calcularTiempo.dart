import 'package:intl/intl.dart';
import 'dart:math';
class TiempoCalculator {
  double calculateTiempo({
    required double capital,
    required double montofuturo,
    required int vecesporano,
    required double interes,
  }) {
    
    return (log(montofuturo/capital)/(log(1 + interes / vecesporano)*vecesporano));
  }

 double calculateInterestRate({
    required double futureAmount,
    required double capital,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final int days = endDate.difference(startDate).inDays;
    final double periodInYears = days / 365.0;

    double rate = (pow(futureAmount / capital, 1 / periodInYears) - 1) * 100;

    return rate;
  }

  String formatNumber(double number) {
    String numberString = number.toStringAsFixed(2);
    List<String> parts = numberString.split('.');
    String integerPart = parts[0];
    String decimalPart = parts.length > 1 ? parts[1] : '';

    StringBuffer formattedInteger = StringBuffer();
    for (int i = 0; i < integerPart.length; i++) {
      if (i > 0 && (integerPart.length - i) % 3 == 0) {
        formattedInteger.write('.');
      }
      formattedInteger.write(integerPart[i]);
    }
    return "${formattedInteger.toString()},${decimalPart}";
  }

  DateTime parseDate(String date) {
    return DateFormat('dd/MM/yyyy').parse(date);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}