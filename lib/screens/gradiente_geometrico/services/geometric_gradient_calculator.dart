import 'dart:math';

class GeometricGradientCalculator {
  // Function to calculate Valor Presente Creciente
  double calculateValorPresenteCreciente({
    required double A,
    required double G,
    required double i,
    required int n,
  }) {
    final double numerator = (pow(1 + G, n) / pow(1 + i, n)) - 1;
    final double denominator = G - i;
    return A / denominator * numerator;
  }

  // Function to calculate Valor Presente Decreciente
  double calculateValorPresenteDecreciente({
    required double A,
    required double G,
    required double i,
    required int n,
  }) {
    final double numerator = (pow(1 - G, n) / pow(1 + i, n)) - 1;
    final double denominator = G + i;
    return A / denominator * numerator;
  }

  // Function to calculate Valor Futuro Creciente
  double calculateValorFuturoCreciente({
  required double A,
  required double G,
  required double i,
  required int n,
}) {
  // Realiza el cálculo usando la función pow y convierte el resultado a double
  final double term1 = (pow(1 + G, n) as double);
  final double term2 = (pow(1 + i, n) as double);
  final double numerator = term1 - term2;
  final double denominator = G - i;
  
  // Asegúrate de que el denominador no sea cero
  if (denominator == 0) {
    throw ArgumentError('G y i no pueden ser iguales para evitar división por cero.');
  }
  
  return (A / denominator) * numerator;
}

  // Function to calculate Valor Futuro Decreciente
  double calculateValorFuturoDecreciente({
  required double A,
  required double G,
  required double i,
  required int n,
}) {
  // Calcula los términos usando pow y convierte el resultado a double
  final double term1 = (pow(1 - G, n) as double);
  final double term2 = (pow(1 + i, n) as double);
  final double numerator = term1 - term2;
  final double denominator = G + i;

  // Asegúrate de que el denominador no sea cero
  if (denominator == 0) {
    throw ArgumentError('G y i no pueden ser iguales para evitar división por cero.');
  }
  
  return (A / denominator) + numerator;
}
}
