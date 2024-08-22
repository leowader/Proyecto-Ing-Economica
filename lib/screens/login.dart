import 'package:flutter/material.dart';

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
      print(password);
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
           
            Image.network(
              'https://static.vecteezy.com/system/resources/previews/025/300/879/large_2x/3d-finance-element-icons-3d-object-for-finance-or-business-icons-free-png.png', 
              width: 100, 
              height: 100, 
            ),
            const SizedBox(height: 20),
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
      foregroundColor: Colors.white, backgroundColor: const Color.fromARGB(255, 21, 24, 26), padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 32.0), // Cambia el color del texto
    ),
    child: const Text("Iniciar Sesión"),
  ),
)
          ],
        ),
      ),
    );
  }
}
