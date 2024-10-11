import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/aritmetico/views/aritmetico_cuota_especifica.dart';
import 'package:ingeconomica/screens/aritmetico/views/aritmetico_presente.dart';
import 'package:ingeconomica/screens/aritmetico/views/aritmetico_presente_infinito.dart';
import 'package:ingeconomica/screens/aritmetico/views/aritmetico_views.dart';
import 'package:ingeconomica/screens/aritmetico/views/gradiente_aritmetico_futuro.dart';
import 'package:ingeconomica/screens/bonos/views/bonos.dart';
import 'package:ingeconomica/screens/compuesto/view/compuesto_view.dart';
import 'package:ingeconomica/screens/compuesto/view/montofuturo.dart';
import 'package:ingeconomica/screens/compuesto/view/tasaInteres.dart';
import 'package:ingeconomica/screens/compuesto/view/tiempo.dart';
import 'package:ingeconomica/screens/home_screen.dart';
import 'package:ingeconomica/screens/login.dart';
import 'package:ingeconomica/screens/register.dart';
import 'package:ingeconomica/screens/simple/view/simple_forms.dart';
import 'package:ingeconomica/screens/simple/view/simple_interes.dart';
import 'package:ingeconomica/screens/simple/view/simple_tiempo.dart';
import 'package:ingeconomica/screens/simple/view/simple_view.dart';
import 'package:ingeconomica/screens/gradiente_geometrico/view/geometric_value_calculator.dart';
import 'package:ingeconomica/screens/gradiente_geometrico/view/geometric_series_calculator.dart';

var routes = <String, WidgetBuilder>{
  "/": (_) => const HomeScreen(
        username: "Tester",
        initialAmount: 2000000,
      ),
  "/bonos": (_) => const Bonos(),
  "/login": (_) => const Login(),
  "/register": (_) => const Register(),
  "/simple": (_) => const SimpleView(),
  "/simple/form": (_) => const SimpleForms(),
  "/simple/interes": (_) => const SimpleInteres(),
  "/simple/tiempo": (_) => const SimpleTiempo(),
  "/compuesto": (_) => const CompuestoView(),
  "/compuesto/montofuturo": (_) => const Montofuturo(),
  "/compuesto/tasainteres": (_) => const TasaInteres(),
  "/compuesto/tiempo": (_) => const Tiempo(),
  "/aritmetico": (_) => const AritmeticoView(),
  "/aritmetico/valorpresente": (_) => const ValorPresente(),
  "/aritmetico/valorfuturo": (_) => const ValorFuturo(),
  "/aritmetico/valorpresenteinfinito": (_) => const ValorPresenteInfinito(),
  "/aritmetico/cuotaespecifica": (_) => const CuotaEspecifica(),
  "/geometric/value": (_) => const GeometricValueCalculator(),
  "/geometric/series": (_) => const GeometricSeriesCalculator(),
};
