import 'package:cinema/data/network/model/session.dart';
import 'package:cinema/ui/schedule/widgets/schedule_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:lumberdash/lumberdash.dart';

import '../../session/session_screen.dart';
import '../bloc/schedule_bloc.dart';

const _noSessions = "no sessions";

class DaySchedule extends StatelessWidget {
  final String movieName;
  final List<Session> sessions;

  const DaySchedule({
    Key? key,
    required this.movieName,
    required this.sessions,
  }) : super(key: key);

  void _openSessionScreen(
    BuildContext context,
    int id,
    List<Session> sessions,
  ) async {
    final Session session = sessions.firstWhere((session) => session.id == id);
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return SessionScreen(
            session: session,
            movieName: movieName,
          );
        },
      ),
    );
    context.read<ScheduleBloc>().add(InitSchedule(
          date: session.date,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
        horizontal: 14.0,
      ),
      child: Wrap(
        runSpacing: 12.0,
        spacing: 12.0,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          if (sessions.isEmpty) const Text(_noSessions),
          if (sessions.isNotEmpty)
            ...sessions.map(
              (entry) {
                return ScheduleItem(
                  onItemTap: () {
                    _openSessionScreen(
                      context,
                      entry.id,
                      sessions,
                    );
                  },
                  time: DateFormat('HH:mm').format(entry.date),
                  type: entry.type,
                );
              },
            ).toList()
        ],
      ),
    );
  }
}
