import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

import '../../../data/network/cinema_rest_client.dart';
import '../../../data/network/model/movie.dart';
import '../../../data/network/model/session.dart';

part 'schedule_event.dart';

part 'schedule_state.dart';

class ScheduleBloc extends Bloc<ScheduleEvent, ScheduleState> {
  final CinemaRestClient client;
  final Movie movie;
  final DateTime selectedDate;

  ScheduleBloc(
    this.client,
    this.movie,
    this.selectedDate,
  ) : super(ScheduleState(
          movie: movie,
          dates: List.generate(
              5, (index) => DateTime.now().add(Duration(days: index))),
          selectedDate: selectedDate,
          sessions: List.empty(),
          loading: true,
          errorMessage: null,
        )) {
    on<InitSchedule>(_onInitSchedule);
  }

  Future<FutureOr<void>> _onInitSchedule(
    InitSchedule event,
    Emitter<ScheduleState> emit,
  ) async {
    logMessage("init movies");
    try {
      emit(state.copyWith(
        loading: true,
      ));
      final sessions = await client.searchSessions(
        event.date,
        movie.id,
      );
      sessions.sort((a, b) => a.date.compareTo(b.date));
      emit(state.copyWith(
        loading: false,
        sessions: sessions,
        selectedDate: event.date,
      ));
    } catch (e) {
      logWarning(e.toString());
      emit(state.copyWith(
        loading: false,
        errorMessage: "Something went wrong",
      ));
    }
  }
}
