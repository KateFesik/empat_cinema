import 'package:flutter/material.dart';

class CinemaButton extends StatelessWidget {
  final VoidCallback onTap;
  final String title;
  final bool isDisabled;

  const CinemaButton({
    Key? key,
    required this.onTap,
    required this.title,
    required this.isDisabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: isDisabled ? null : onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 14.0),
            child: Text(
              title,
            ),
          ),
        ),
      ),
    );
  }
}
