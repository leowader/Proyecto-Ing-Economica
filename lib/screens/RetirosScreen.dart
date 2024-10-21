import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class RetirosScreen extends StatefulWidget {
  final Function(double) onRetiroRealizado; // Callback for successful withdrawal

  const RetirosScreen({super.key, required this.onRetiroRealizado});

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
      final String cantidadStr = _montoController.text;
      double cantidad = double.tryParse(cantidadStr) ?? 0;

      if (cantidad > 0) {
        widget.onRetiroRealizado(cantidad); // Call the function passed from HomeScreen
        _mostrarNotificacion(cantidadStr);

        Navigator.pop(context); // Close the RetirosScreen after successful transaction
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ingresa una cantidad válida')),
        );
      }
    } else {
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
            const Text(
              'Confirma el monto a retirar:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _montoController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Monto a retirar',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              icon: const Icon(Icons.check),
              onPressed: _retirarDinero,
              label: const Text('Confirmar retiro'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                    horizontal: 32.0, vertical: 16.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
