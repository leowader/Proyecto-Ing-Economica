import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart'; // Para la autenticación biométrica
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Para las notificaciones

class RetirosScreen extends StatefulWidget {
  const RetirosScreen({super.key});

  @override
  _RetirosScreenState createState() => _RetirosScreenState();
}

class _RetirosScreenState extends State<RetirosScreen> {
  final TextEditingController _montoController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _mostrarNotificacion(String cantidad) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      //'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Retiro realizado',
      'Has retirado \$ $cantidad',
      platformChannelSpecifics,
    );
  }

  Future<void> _retirarDinero() async {
    final bool isAuthenticated = await auth.authenticate(
      localizedReason: 'Confirma tu identidad para realizar el retiro',
      options: const AuthenticationOptions(biometricOnly: true),
    );

    if (isAuthenticated) {
      final String cantidad = _montoController.text;
      // Lógica para restar la cantidad de la cuenta actual del usuario
      _mostrarNotificacion(cantidad);
    } else {
      // Manejar caso de fallo en la autenticación
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Autenticación fallida')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Retiros'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _montoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Monto a retirar',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _retirarDinero,
              child: const Text('Confirmar retiro'),
            ),
          ],
        ),
      ),
    );
  }
}
