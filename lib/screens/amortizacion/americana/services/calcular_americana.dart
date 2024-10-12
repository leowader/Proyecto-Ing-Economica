class CalcularAmericana {
  final double principal;
  final double tasaInteresAnual;
  final int anios; // Cambiado de años a anios

  CalcularAmericana({
    required this.principal,
    required this.tasaInteresAnual,
    required this.anios, // Cambiado de años a anios
  });

  Map<String, dynamic> calcularAmortizacion() {
    double tasaInteresMensual = tasaInteresAnual / 12 / 100;
    int meses = anios * 12; // Cambiado de años a anios

    double pagoInteresMensual = principal * tasaInteresMensual;
    double totalIntereses = pagoInteresMensual * meses;
    double totalPago = principal + totalIntereses;

    return {
      'pagoInteresMensual': pagoInteresMensual,
      'totalIntereses': totalIntereses,
      'totalPago': totalPago,
      'meses': meses,
    };
  }
}
