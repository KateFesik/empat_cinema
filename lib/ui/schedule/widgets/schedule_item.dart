import 'package:flutter/material.dart';

class ScheduleItem extends StatelessWidget {
  final VoidCallback onItemTap;
  final String time;
  final String type;

  const ScheduleItem({
    Key? key,
    required this.onItemTap,
    required this.time,
    required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onItemTap,
      child: Container(
        width: 80.0,
        height: 60.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              time,
            ),
            Text(
              type,
            ),
          ],
        ),
      ),
    );
  }
}
