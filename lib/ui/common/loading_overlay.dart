import 'package:flutter/material.dart';

class LoadingOverlay extends StatelessWidget {
  final bool loading;
  final Widget child;

  const LoadingOverlay({
    super.key,
    required this.loading,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (loading)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 32),
            child: Align(
              alignment: Alignment.center,
              child: CircularProgressIndicator(),
            ),
          )
      ],
    );
  }
}
