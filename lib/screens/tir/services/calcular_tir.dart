import 'dart:math';

class CalcularTIR {
  // Método para calcular la TIR usando la fórmula estándar
  double calcularTIR(List<double> flujos, double inversionInicial) {
    // Aproximación inicial de TIR
    double tir = 0.1; // TIR inicial (10%)
    double precision = 0.0001; // Precisión para detener la búsqueda
    double van = 0.0;
    int maxIteraciones = 1000; // Máximo número de iteraciones

    for (int i = 0; i < maxIteraciones; i++) {
      van = -inversionInicial; // Comenzar con la inversión inicial negativa
      for (int n = 0; n < flujos.length; n++) {
        // Cálculo del VAN usando la fórmula dada
        van += flujos[n] / pow(1 + tir, n + 1);
      }

      if (van.abs() < precision) {
        return tir * 100; // Devolver TIR en porcentaje
      }

      // Ajustar TIR según si el VAN es positivo o negativo
      tir += (van > 0) ? 0.01 : -0.01;
    }

    return tir * 100; // Si no converge, devolver la TIR calculada
  }

  // Método para calcular la TIR usando prueba y error
  double calcularTIRPruebaError(List<double> flujos, double inversionInicial) {
    double tir = 0.1; // TIR inicial (10%)
    double precision = 0.0001; // Precisión para detener la búsqueda
    double van = 0.0;
    int maxIteraciones = 1000; // Máximo número de iteraciones

    for (int i = 0; i < maxIteraciones; i++) {
      van = -inversionInicial; // Comenzar con la inversión inicial negativa
      for (int n = 0; n < flujos.length; n++) {
        // Cálculo del VAN usando la fórmula de prueba y error
        van += flujos[n] / pow(1 + tir, n); // n+1 para la fórmula estándar, n para prueba y error
      }

      if (van.abs() < precision) {
        return tir * 100; // Devolver TIR en porcentaje
      }

      // Ajustar TIR según si el VAN es positivo o negativo
      tir += (van > 0) ? 0.01 : -0.01;
    }

    return tir * 100; // Si no converge, devolver la TIR calculada
  }
}
