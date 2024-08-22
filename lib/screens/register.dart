import 'package:flutter/material.dart';

class Register extends StatelessWidget {
  const Register({super.key});
  static String id = "register";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("register")),
      body: const Center( child:  Text("register"),),
    );
  }
}
