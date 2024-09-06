import 'package:flutter/material.dart';
// import 'package:flutter_web_plugins/flutter_web_plugins.dart'; // Importa flutter_web_plugins
import 'package:ingeconomica/routes/routes.dart';

void main() {
  // Configura Flutter para usar la estrategia de URL sin hash.
  // setUrlStrategy(PathUrlStrategy());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Ing Economica",
      initialRoute: "/login",
      routes: routes,
    );
  }
}
