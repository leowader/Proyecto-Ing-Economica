import 'package:flutter/material.dart';

  Widget buildTextField(TextEditingController controller, String label) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      keyboardType: TextInputType.number,
      
    );
  }
/*
class TextFormFieldP extends StatelessWidget {
  const TextFormFieldP({
    super.key,
    required TextEditingController capitalController,
  }) : _capitalController = capitalController;

  final TextEditingController _capitalController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _capitalController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "pago",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Por favor ingrese el pago';
        }
        return null;
      },
    );
  }
}*/