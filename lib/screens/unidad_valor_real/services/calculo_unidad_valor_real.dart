import 'package:intl/intl.dart';
import 'dart:math';
class UVRCalculator {
  
  double calculateUVR({
    required double valorMoneda,
    required double variacion,
    required int numDias,
    required int periodoCalculo}){
      variacion = variacion / 100;

      double uvr = valorMoneda * pow(1 + variacion,numDias/periodoCalculo);

      return uvr;
  }
  List<double> calculateListUVR({
    required double valorMoneda,
    required double variacion,
    required int periodoCalculo}){
      variacion = variacion / 100;
      List<double> uvr = [];
      for (int i=0; i<periodoCalculo; i++){
        double result = valorMoneda * pow(1 + variacion,(i+1)/periodoCalculo);
        uvr.add(result);
      }
      print(uvr.length);
      return uvr;
  }

  List<DateTime> createDates({
    required DateTime fechaI,
    required int periodo,
  }){
    List<DateTime> lFechas = [];
    for (int i=0; i<periodo; i++){
      lFechas.add((fechaI.add(Duration(days: i+1))));
    }

    return lFechas;
  }
  
  double calculatePeriod({
    required double days,
    required double months,
    required double years,
    required String mcuota,
  }){
    double periodo=0;

    if (mcuota == "Mensual"){
      double periodo = (days/30+months+years*12);
      return periodo;
    } else if(mcuota == "Anual"){
      double periodo = (days/360+months/12+years);
      return periodo;
    }else if(mcuota == "Bimestral"){
      double periodo = (days/60+months/2+years*6);
      return periodo;
    }else if(mcuota == "Trimestral"){
      double periodo = (days/90+months/3+years*4);
      return periodo;
    }else if(mcuota == "Semestral"){
      double periodo = (days/180+months/6+years*2);
      return periodo;
    }
    return periodo;
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