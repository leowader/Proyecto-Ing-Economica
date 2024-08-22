import 'package:flutter/material.dart';
import 'package:ingeconomica/routes/routes.dart';

void main() {
  runApp(const Myapp());
}


class Myapp extends StatelessWidget{
  const Myapp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Ing economica",
        initialRoute: "/",
        routes: routes
    );
  }
}