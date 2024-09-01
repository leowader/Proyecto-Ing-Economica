import 'package:flutter/material.dart';
import 'package:ingeconomica/screens/compuesto/view/compuesto_view.dart';
import 'package:ingeconomica/screens/compuesto/view/montofuturo.dart';
import 'package:ingeconomica/screens/compuesto/view/tasaInteres.dart';
import 'package:ingeconomica/screens/compuesto/view/tiempo.dart';
import 'package:ingeconomica/screens/home_screen.dart';
import 'package:ingeconomica/screens/login.dart';
import 'package:ingeconomica/screens/register.dart';
import 'package:ingeconomica/screens/simple/view/simple_forms.dart';
import 'package:ingeconomica/screens/simple/view/simple_interes.dart';
import 'package:ingeconomica/screens/simple/view/simple_view.dart';

var routes = <String, WidgetBuilder>{
  "/": (_) => const HomeScreen(username: "leowader",initialAmount: 2000000,),
  "/login": (_) => const Login(),
  "/register": (_) => const Register(),
  "/simple": (_) => const SimpleView(),
  "/simple/form": (_) => const SimpleForms(),
    "/simple/interes": (_) =>  const SimpleInteres(),
  "/compuesto":(_) => const CompuestoView(),
  "/compuesto/montofuturo":(_) => const Montofuturo(),
  "/compuesto/tasainteres": (_) => const TasaInteres(),
  "/compuesto/tiempo": (_) => const Tiempo()
};
