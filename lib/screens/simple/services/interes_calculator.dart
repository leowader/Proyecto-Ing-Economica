import 'package:intl/intl.dart';
import 'dart:math';

class InterestCalculator {
  //MONTO FINAL
  double calculateFutureAmount({
    required double capital,
    required double rate,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    final double time = endDate.difference(startDate).inDays / 360;
    return capital * (1 + (rate / 100) * time);
  }

  double calculateInterestRate({
    required double futureAmount,
    required double capital,
    required DateTime startDate,
    required DateTime endDate,
  }) {
    print("aquiii");
    final int days = endDate.difference(startDate).inDays;
    final double periodInYears = days / 360;

    double rate = (pow(futureAmount / capital, 1 / periodInYears) - 1) * 100;
    print(rate);
    return rate;
  }

  double calculateTime(
      double interesPagado, double initialCapital, double interestRate) {
    return (interesPagado / (initialCapital * (interestRate / 100)));
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
    return '${formattedInteger.toString()},$decimalPart';
  }

  DateTime parseDate(String date) {
    return DateFormat('dd/MM/yyyy').parse(date);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }

  calculateInitialCapital(
      {required double finalCapital,
      required double rate,
      required DateTime startDate,
      required int tiempo,
      required DateTime endDate}) {
    final tasa = rate / 100;
    final division = ((tasa * tiempo));
    print(double.parse(division.toStringAsFixed(1)));
    final resultado = (finalCapital / (tasa * tiempo));
    return resultado;
  }

  calculateInitialCapitalPrestamo(
      {required double finalCapital,
      required double rate,
      required DateTime startDate,
      required int tiempo,
      required DateTime endDate}) {
    final tasa = rate / 100;

    final division = (1 + double.parse(tasa.toStringAsFixed(2)) * tiempo);
    print('${finalCapital } / ${double.parse(division.toStringAsFixed(1))}');

    final resultado = (finalCapital / division);
    return resultado;
  }
}
