import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PaymentField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final bool? enabled;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final bool obscureText;

  const PaymentField({
    Key? key,
    required this.hint,
    required this.controller,
    this.enabled,
    this.keyboardType,
    this.inputFormatters,
    this.obscureText = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        textInputAction: TextInputAction.next,
        onEditingComplete: () => FocusScope.of(context).nextFocus(),
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
        enabled: enabled,
        keyboardType: keyboardType,
        inputFormatters: inputFormatters,
        obscureText: obscureText,
      ),
    );
  }
}
