import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onSubmitted;
  final bool? enabled;
  final TextInputType? keyboardType;

  const InputField({
    Key? key,
    required this.hint,
    required this.controller,
    this.onSubmitted,
    this.enabled,
    this.keyboardType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        onSubmitted: onSubmitted,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
        enabled: enabled,
        keyboardType: keyboardType,
      ),
    );
  }
}
