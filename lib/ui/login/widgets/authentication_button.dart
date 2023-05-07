import 'package:flutter/material.dart';

class AuthenticationButton extends StatelessWidget {
  final VoidCallback onSubmitted;

  const AuthenticationButton({Key? key, required this.onSubmitted})
      : super(key: key);

  final String _buttonText = "Submit";

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: 300.0,
        child: ElevatedButton(
          onPressed: onSubmitted,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              _buttonText,
            ),
          ),
        ),
      ),
    );
  }
}
