import 'package:intl/intl.dart';
import 'dart:math';
class EAICalculator {
  
  double calcularVPN({
    required List<double> fcaja,
    required double tasadescuento,
    required double invInicial
  }){
    late double sumatoria = 0;
    tasadescuento = tasadescuento/100;

    for (int i=0;i < fcaja.length; i++){
      sumatoria = sumatoria + (fcaja[i]/(pow(1+tasadescuento,i+1)));
      //print(fcaja[i]/(pow(1+tasadescuento,i+1)));
    }
    double vpn = sumatoria - invInicial;

    return vpn;
  }

   double calculateIR({
    required double vpn,
    required double invInicial,
  }){
    double iR = (vpn+invInicial)/invInicial;
    return iR;
  }

  double calculatePRI({
    required List<double> fcaja,
    required double invInicial,
    required String tPerido,
  }){
    double progreso = -invInicial;
    double anteriorValor = 0;
    for (int i=0;i<fcaja.length;i++){
      anteriorValor = progreso;
      progreso = progreso +fcaja[i];
      if (progreso > 0){
        double tri =0;
        tri = i-(anteriorValor/fcaja[i]);
        return tri; 
      }
    }
    if (progreso < 0){
      double prom = (fcaja.reduce((value, element) => value + element)/fcaja.length);
      int i =0;
      while (progreso < 0){
        anteriorValor = progreso;
        progreso = progreso + prom;
        i++; 
      }
      double tri =0;
      tri = (((i-1)+fcaja.length)-(anteriorValor/prom));

     return tri;
    }
    return 0;
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