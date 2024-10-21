import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart'; // Importa para autenticación biométrica
import 'package:flutter_local_notifications/flutter_local_notifications.dart'; // Importa para notificaciones

class Pagos extends StatefulWidget {
  final double saldoDisponible;
  final Function(double pago, String descripcion) onPagoRealizado;

  const Pagos({super.key, required this.saldoDisponible, required this.onPagoRealizado});

  @override
  _PagosState createState() => _PagosState();
}

class _PagosState extends State<Pagos> {
  final _formKey = GlobalKey<FormState>();
  double cuota = 0.0;
  String descripcion = '';
  final LocalAuthentication auth = LocalAuthentication();
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    const InitializationSettings initializationSettings = InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> _mostrarNotificacion(double cantidad) async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      importance: Importance.max,
      priority: Priority.high,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(
      0,
      'Pago realizado',
      'Has pagado \$${cantidad.toStringAsFixed(2)}',
      platformChannelSpecifics,
    );
  }

  Future<void> _pagarCuota() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      if (cuota <= widget.saldoDisponible) {
        // Realiza la autenticación biométrica
        final bool isAuthenticated = await auth.authenticate(
          localizedReason: 'Confirma tu identidad para realizar el pago',
          options: const AuthenticationOptions(biometricOnly: true),
        );

        if (isAuthenticated) {
          // Realiza el pago y notifica a la HomeScreen
          widget.onPagoRealizado(cuota, descripcion);

          // Muestra la notificación
          _mostrarNotificacion(cuota);

          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Pago exitoso.'),
          ));

          // Regresar a la HomeScreen
          Navigator.pop(context);
        } else {
          // Manejar caso de fallo en la autenticación
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Autenticación fallida')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Saldo insuficiente para pagar la cuota.'),
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Pagar Cuota')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Saldo disponible: \$${widget.saldoDisponible.toStringAsFixed(2)}',
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Cuota a pagar'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, ingresa un monto';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Por favor, ingresa un número válido';
                  }
                  return null;
                },
                onSaved: (value) {
                  cuota = double.parse(value!);
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Descripción del pago'),
                onSaved: (value) {
                  descripcion = value ?? '';
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pagarCuota,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(20),
                  backgroundColor: const Color(0xFF232323),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Pagar"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
