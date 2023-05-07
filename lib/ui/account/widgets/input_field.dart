import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextEditingController? controller;
  final ValueChanged<String>? onNameSubmitted;
  final bool? enabled;

  const InputField({
    Key? key,
    required this.hint,
    required this.controller,
    this.onNameSubmitted,
    this.enabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        controller: controller,
        onSubmitted: onNameSubmitted,
        decoration: InputDecoration(
          labelText: hint,
          border: const OutlineInputBorder(),
        ),
        enabled: enabled,
      ),
    );
  }
}
