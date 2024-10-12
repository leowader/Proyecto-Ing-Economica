class CalcularAmericana {
  final double principal; // Capital prestado (Co)
  final double tasaInteresAnual; // Tasa de interés anual
  final int anios; // Duración del préstamo en años

  CalcularAmericana({
    required this.principal,
    required this.tasaInteresAnual,
    required this.anios,
  });

  // Método para calcular la amortización americana
  Map<String, dynamic> calcularAmortizacion() {
    // Convertir la tasa de interés anual a una tasa de interés mensual
    double tasaInteresMensual = tasaInteresAnual / 12 / 100;
    int meses = anios * 12;

    // Calcular el interés mensual (I)
    double interesMensual = principal * tasaInteresMensual;

    // El último pago (a´) será la suma del capital (Co) y el interés del último período (I)
    double ultimoPago = principal + interesMensual;

    // El total de intereses es el interés mensual multiplicado por el número de meses
    double totalIntereses = interesMensual * meses;

    // Retornar los resultados
    return {
      'interesMensual': interesMensual,
      'totalIntereses': totalIntereses,
      'ultimoPago': ultimoPago,
      'meses': meses,
    };
  }
}
