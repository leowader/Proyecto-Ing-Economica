import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/alternativa_inversion/views/eai_pri.dart';
import 'package:ingeconomica/screens/alternativa_inversion/views/eai_vpn.dart';
import 'package:ingeconomica/screens/alternativa_inversion/views/evaluacion_alternativa_inversion_views.dart';
import 'package:ingeconomica/screens/amortizacion/view/alemana_view.dart';
import 'package:ingeconomica/screens/amortizacion/view/americana_view.dart';
import 'package:ingeconomica/screens/amortizacion/view/amortizacion_view.dart';
import 'package:ingeconomica/screens/amortizacion/view/francesa.dart';
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
import 'package:ingeconomica/screens/inflacion/view/inflacion.dart';
import 'package:ingeconomica/screens/login.dart';
import 'package:ingeconomica/screens/pagos/pagos.dart';
import 'package:ingeconomica/screens/register.dart';
import 'package:ingeconomica/screens/simple/view/simple_forms.dart';
import 'package:ingeconomica/screens/simple/view/simple_interes.dart';
import 'package:ingeconomica/screens/simple/view/simple_tiempo.dart';
import 'package:ingeconomica/screens/simple/view/simple_view.dart';
import 'package:ingeconomica/screens/gradiente_geometrico/view/geometric_value_calculator.dart';
import 'package:ingeconomica/screens/gradiente_geometrico/view/geometric_series_calculator.dart';
import 'package:ingeconomica/screens/unidad_valor_real/views/unidad_valor_real_views.dart';
import 'package:ingeconomica/screens/unidad_valor_real/views/uvr_form.dart';
import 'package:ingeconomica/screens/unidad_valor_real/views/uvr_table.dart';
import 'package:ingeconomica/screens/tir/view/tir_form.dart';

var routes = <String, WidgetBuilder>{
  "/": (_) => const HomeScreen(
        username: "",
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
  "/amortizacion": (_) => const AmortizacionView(),
  "/amortizacion/francesa": (_) => const Francesa(),
  "/amortizacion/alemana": (_) => const AlemanaView(),
  "/amortizacion/americana": (_) =>  AmericaView(),
  "/inflacion": (_) => const Inflacion(),
  "/tir": (_)=>  TIRView(),

  "/aritmetico": (_) => const AritmeticoView(),
  "/aritmetico/valorpresente": (_) => const ValorPresente(),
  "/aritmetico/valorfuturo": (_) => const ValorFuturo(),
  "/aritmetico/valorpresenteinfinito": (_) => const ValorPresenteInfinito(),
  "/aritmetico/cuotaespecifica": (_) => const CuotaEspecifica(),
  "/geometric/value": (_) => const GeometricValueCalculator(),
  "/geometric/series": (_) => const GeometricSeriesCalculator(),
  
  "/unidadvalorreal": (_) => const UnidadValorRealView(),
  "/unidadvalorreal/valor": (_) => const UnidadValorReal(),
  "/unidadvalorreal/tabla": (_) => const UnidadValorRealTabla(),
  "/evaluacionai": (_) => const EvaluacionAlternativaInversionView(),
  "/evaluacionai/vpn_ir": (_) => const EvaluacionAlternativaInversionVPN(),
  "/evaluacionai/pri": (_) => const EvaluacionAlternativaInversionPRIAR(),
};
