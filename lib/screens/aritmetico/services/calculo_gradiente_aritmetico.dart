import 'package:intl/intl.dart';
import 'dart:math';
class GradienteACalculator {
  
 double calculatePresentValue({
    required double pago,
    required double gradiente,
    required double periodos,
    required double interes,
  }) {
    interes = interes/100;

    double presentValue =  pago*((pow(1+interes,periodos)-1)/(interes*pow( 1 + interes, periodos)))+(gradiente/interes)*((pow(1 + interes, periodos)-1)/(interes*(pow(1 + interes,periodos)))-(periodos/pow(1 + interes, periodos)));

    return presentValue;
  }

   double calculateFutureValue({
    required double pago,
    required double gradiente,
    required double periodos,
    required double interes,
  }) {
    interes = interes/100;

    double futureValue =  pago*((pow(1+interes,periodos)-1)/(interes))+(gradiente/interes)*((pow(1 + interes, periodos)-1)/(interes)-(periodos));

    return futureValue;
  }

  double calculateInfinitePresentValue({
    required double pago,
    required double gradiente,
    required double interes,
  }) {
    interes = interes/100;

    double infinitePresentValue =  (pago/interes)+(gradiente/pow(interes,2));

    return infinitePresentValue;
  }

  double calculateSpecificQouta({
    required double pago,
    required double gradiente,
    required double periodos
  }) {
    
    double specificQuota =  (pago + (periodos - 1) * gradiente);

    return specificQuota;
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

  DateTime parseDate(String date) {
    return DateFormat('dd/MM/yyyy').parse(date);
  }

  String formatDate(DateTime date) {
    return DateFormat('dd/MM/yyyy').format(date);
  }
}