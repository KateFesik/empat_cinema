import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data/network/model/session.dart';

class SessionTextDate extends StatelessWidget {
  final Session session;

  const SessionTextDate({
    super.key,
    required this.session,
  });

  String _convertDate(DateTime date) {
    return "${DateFormat.EEEE().format(date)}, "
        "${DateFormat('HH:mm').format(date)}";
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      "${_convertDate(session.date)} - ${session.type}",
      style: Theme.of(context).textTheme.titleMedium!.copyWith(
        color: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
