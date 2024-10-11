import 'dart:math';

class Calcularfrancesar {
  double calculateFutureAmount({
    required double montoPrestamo,
    required double tasaInteresAnual,
    required int plazoMeses,
  }) {
    double tasaInteresMensual = tasaInteresAnual / 12 / 100;
    return montoPrestamo *
        tasaInteresMensual *
        pow(1 + tasaInteresMensual, plazoMeses) /
        (pow(1 + tasaInteresMensual, plazoMeses) - 1);
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
    return '\$${formattedInteger.toString()},$decimalPart';
  }
}
