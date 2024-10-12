import 'package:intl/intl.dart';
import 'dart:math';
class EAICalculator {
  
  /*double calculateVPN({
    required double gasto,
    required double arrendamiento,
    required double interes,
    required double periodo,
    required double venta,
  }){

    double vpi = arrendamiento*((pow(1 + interes, periodo)-1)/(interes*pow(1 + interes, periodo)))+(venta/pow(1 + interes,periodo));
    double vpn = vpi - gasto; 
    return vpn;
  }*/

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

  double calculateTIRPE({
    required List<double> flcaja,
    required double tasadescuento,
    required double invInicial
  }){
    tasadescuento = tasadescuento/100;
    int maxIteraciones = 500;
    late double tir = tasadescuento;
    List<double>fc = [-invInicial] + flcaja;
    for (int i = 0; i < maxIteraciones; i++) {
    double vpn = 0.0;
    double vpnDerivada = 0.0;
    double tolerancia = 1e-6;
    for (int t = 0; t < fc.length; t++) {
      vpn += fc[t] / pow(1 + tir, t);
      vpnDerivada += -t * fc[t] / pow(1 + tir, t + 1);
    }
    // Verificamos si el VPN está dentro de la tolerancia
    if (vpn.abs() < tolerancia) {
      tir = tir*100;
      return tir;
    }
    // Actualizamos la tir usando el método de Newton-Raphson
    tir -= vpn / vpnDerivada;
  }
  print(tir);
  tir = tir*100;
  return tir;
  }

  double calculateTIRIL({
    required List<double> fcaja,
    required double tasadescuento,
    required double tasadescuento2,
    required double invInicial,
  }){
    double vpn1 = calcularVPN(fcaja: fcaja, tasadescuento: tasadescuento, invInicial: invInicial);
    double vpn2 = calcularVPN(fcaja: fcaja, tasadescuento: tasadescuento2, invInicial: invInicial);
    double tir = tasadescuento+(vpn1/(vpn1-vpn2))*(tasadescuento2-tasadescuento);
    print(tir);
    return tir;
  }

  double calculateTIRA({
    required double cajaUnico,
    required double invInicial,
    required double periodo,
  }){
    double tir = pow(cajaUnico/invInicial, 1/periodo)-1;
    return (tir*100);
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