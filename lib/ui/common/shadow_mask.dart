import 'package:flutter/material.dart';

class ShadowBottomMask extends StatelessWidget {
  final Widget child;

  const ShadowBottomMask({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.01),
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.5),
          ],
          stops: const [0.0, 0.5, 1.0],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          tileMode: TileMode.repeated,
        ),
      ),
      child: child,
    );
  }
}

class ShadowTopMask extends StatelessWidget {
  final Widget child;

  const ShadowTopMask({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 120,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black.withOpacity(0.5),
            Colors.black.withOpacity(0.2),
            Colors.black.withOpacity(0.01),
          ],
          stops: const [0.0, 0.7, 1.0],
          begin: FractionalOffset.topCenter,
          end: FractionalOffset.bottomCenter,
          tileMode: TileMode.repeated,
        ),
      ),
      child: child,
    );
  }
}
