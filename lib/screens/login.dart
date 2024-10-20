import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ingeconomica/screens/biometric_auth.dart';
import 'package:ingeconomica/screens/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _ccController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final BiometricAuth _biometricAuth = BiometricAuth();
  bool _showPasswordLogin = false;
  bool _canCheckBiometrics = false;

  @override
  void initState() {
    super.initState();
    _checkDeviceForBiometrics();
  }

  Future<void> _checkDeviceForBiometrics() async {
    bool canCheckBiometrics = await _biometricAuth.canCheckBiometrics();
    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });

    if (canCheckBiometrics) {
      _authenticateBiometric();
    } else {
      setState(() {
        _showPasswordLogin = true;
      });
    }
  }

  Future<void> _authenticateBiometric() async {
    bool isAuthenticated = await _biometricAuth.authenticateWithBiometrics();
    if (isAuthenticated) {
      Navigator.pushNamed(context, "/");
    } else {
      setState(() {
        _showPasswordLogin = true;
      });
    }
  }

  Future<void> _login() async {
    String cc = _ccController.text;
    String password = _passwordController.text;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? storedCC = prefs.getString('cedula');
    String? storedPassword = prefs.getString('password');

    if (cc == storedCC && password == storedPassword) {
      Navigator.pushNamed(context, "/");
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Cédula o contraseña incorrecta")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Get the screen dimensions
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(screenWidth * 0.05), // 5% padding
        child: SingleChildScrollView( // Allows scrolling if content is too large
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: SvgPicture.asset(
                  'assets/logo.svg',
                  width: screenWidth * 0.4, // 40% of screen width
                  height: screenHeight * 0.3, // 30% of screen height
                ),
              ),
              const SizedBox(height: 40),
              if (!_showPasswordLogin) ...[
                const CircularProgressIndicator(),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _showPasswordLogin = true;
                    });
                  },
                  child: const Text("Cancelar autenticación biométrica"),
                ),
              ] else ...[
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
                  width: double.infinity,
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
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Register()),
                      );
                    },
                    child: const Text("¿No tienes cuenta? Regístrate aquí"),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
