import 'package:intl/intl.dart';
import 'dart:math';
class InterestCalculator {
  double calculateTasaInteres({
    required double capital,
    required double montofuturo,
    required int vecesporano,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final double time = endDate.difference(startDate).inDays / 365;
    print(time);
    return (vecesporano * (pow(montofuturo/capital, (1/(vecesporano*time)))-1))*100;
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