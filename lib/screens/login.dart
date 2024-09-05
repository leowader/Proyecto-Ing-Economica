import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Importa el paquete para SVG

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _ccController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() {
    String cc = _ccController.text;
    String password = _passwordController.text;

    if (password == "1234") {
      Navigator.pushNamed(context, "/");
      print(cc);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Contraseña incorrecta")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center, // Centra el contenido verticalmente
          children: <Widget>[
            Center(
              child: SvgPicture.asset(
                'assets/logo.svg', 
                width: 150,
                height: 300, 
              ),
            ),
            const SizedBox(height: 40), 
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Cédula",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _ccController,
                  decoration: InputDecoration(
                    labelText: "Cédula",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 12.0),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Contraseña",
                  style: TextStyle(fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: "Contraseña",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0, horizontal: 12.0),
                  ),
                  obscureText: true,
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity, // Ajusta el botón al ancho de la pantalla
              child: ElevatedButton(
                onPressed: _login,
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: const Color.fromARGB(255, 21, 24, 26),
                  padding: const EdgeInsets.symmetric(
                      vertical: 16.0, horizontal: 32.0),
                ),
                child: const Text("Iniciar Sesión"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
