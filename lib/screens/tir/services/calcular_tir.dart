import 'dart:math';

class CalcularTIR {
  // Método para calcular la TIR Simple
  double calcularTIRSimple(List<double> flujos, double inversionInicial, double tasaInicial) {
    double tir = tasaInicial;
    double precision = 0.0001;
    double variacion = 1.0;

    while (variacion.abs() > precision) {
      double npv = 0.0; // Valor actual neto
      for (int i = 0; i < flujos.length; i++) {
        npv += flujos[i] / pow(1 + tir, i + 1);
      }

      npv -= inversionInicial;
      variacion = npv;
      tir = tir - (npv / (inversionInicial * flujos.length)); // Ajustar la TIR
    }

    return tir * 100; // Devolver la TIR en porcentaje
  }

  // Método para calcular la TIR Modificada (MIRR)
  double calcularMIRR(List<double> flujos, double inversionInicial, double tasaFinanciamiento, double tasaReinversion) {
    double valorPresente = 0.0;
    double valorFuturo = 0.0;
    int n = flujos.length;

    for (int i = 0; i < n; i++) {
      if (flujos[i] < 0) {
        valorPresente += flujos[i] / pow(1 + tasaFinanciamiento, i + 1);
      } else {
        valorFuturo += flujos[i] * pow(1 + tasaReinversion, n - (i + 1));
      }
    }

    return pow(valorFuturo / -valorPresente, 1 / n) - 1;
  }

  // Método para calcular la TIR Incremental
  double calcularTIRIncremental(List<double> flujosProyecto1, List<double> flujosProyecto2, double tasaInicial) {
    List<double> diferenciaFlujos = [];

    for (int i = 0; i < flujosProyecto1.length; i++) {
      diferenciaFlujos.add(flujosProyecto1[i] - flujosProyecto2[i]);
    }

    return calcularTIRSimple(diferenciaFlujos, 0, tasaInicial);
  }
}
