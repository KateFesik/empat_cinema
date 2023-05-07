import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/cinema_rest_client.dart';
import '../../../data/network/model/movie.dart';
import '../../common/loading_overlay.dart';
import '../bloc/schedule_bloc.dart';
import 'calendar.dart';
import 'day_schedule.dart';

class ScheduleWidget extends StatefulWidget {
  final Movie movie;
  final DateTime selectedDate;

  const ScheduleWidget({
    Key? key,
    required this.movie,
    required this.selectedDate,
  }) : super(key: key);

  @override
  State<ScheduleWidget> createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget>
    with AutomaticKeepAliveClientMixin<ScheduleWidget> {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<ScheduleBloc>(
      create: (context) {
        return ScheduleBloc(
          context.read<CinemaRestClient>(),
          widget.movie,
          widget.selectedDate,
        )..add(InitSchedule(
            date: widget.selectedDate,
          ));
      },
      child: BlocBuilder<ScheduleBloc, ScheduleState>(
        builder: (BuildContext context, ScheduleState state) {
          return LoadingOverlay(
            loading: state.loading,
            child: Column(
              children: [
                Calendar(
                  selectedDate: state.selectedDate,
                  dates: state.dates,
                  onClick: (date) {
                    context.read<ScheduleBloc>().add(InitSchedule(date: date));
                  },
                ),
                DaySchedule(
                  movieName: widget.movie.name,
                  sessions: state.sessions,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
