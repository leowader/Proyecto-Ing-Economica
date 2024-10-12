class Calcularalemana {
  List<Map<String, double>> calculateFutureAmount({
    required double montoPrestamo,
    required double tasaInteresAnual,
    required int plazoMeses,
  }) {
    double tasaInteresMensual = tasaInteresAnual / 12 / 100;

    // Amortización constante de capital
    double amortizacionCapital = montoPrestamo / plazoMeses;

    List<Map<String, double>> cuotas = [];

    for (int t = 1; t <= plazoMeses; t++) {
      // Calcular los intereses del periodo
      double interesesPeriodo =
          (montoPrestamo - (t - 1) * amortizacionCapital) * tasaInteresMensual;

      // Cuota total en el periodo
      double cuotaTotal = amortizacionCapital + interesesPeriodo;

      cuotas.add({
        'Periodo': t.toDouble(),
        'Cuota': cuotaTotal,
        'Capital': amortizacionCapital,
        'Intereses': interesesPeriodo
      });
    }

    return cuotas;
  }
}
