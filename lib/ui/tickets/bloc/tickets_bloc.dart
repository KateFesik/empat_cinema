import 'dart:async';

import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

import '../../../data/network/cinema_rest_client.dart';
import '../../../data/network/model/ticket.dart';

part 'tickets_event.dart';

part 'tickets_state.dart';

class TicketsBloc extends Bloc<TicketsEvent, TicketsState> {
  final CinemaRestClient client;

  TicketsBloc(
    this.client,
  ) : super(const TicketsState(
          tickets: {},
          loading: false,
          errorMessage: null,
        )) {
    on<TicketsStarted>(_onTicketsStarted);
    on<TicketsErrorShown>(_onTicketsErrorShown);
  }

  Future<FutureOr<void>> _onTicketsStarted(
    TicketsStarted event,
    Emitter<TicketsState> emit,
  ) async {
    logMessage("started tickets");
    try {
      emit(state.copyWith(
        loading: true,
      ));
      final tickets = await client.getTickets();
      final upcomingTickets = _sanitizeTickets(tickets);
      final groupTickets = _groupTicketsByMovieAndDate(upcomingTickets);

      emit(state.copyWith(
        loading: false,
        tickets: groupTickets,
      ));
    } catch (e) {
      logWarning(e.toString());
      emit(state.copyWith(
        loading: false,
        errorMessage: "Something went wrong",
      ));
    }
  }

  List<Ticket> _sanitizeTickets(List<Ticket> tickets) {
    DateTime now = DateTime.now();
    final upcomingTickets = tickets.where((ticket) => ticket.date.isAfter(now)).toList();
    upcomingTickets.sort((a, b) => a.date.compareTo(b.date));
    return upcomingTickets;
  }

  Map<String, List<Ticket>> _groupTicketsByMovieAndDate(List<Ticket> tickets) {
    return tickets.groupListsBy((ticket) => '${ticket.movieId}-${ticket.date}');
  }

  Future<FutureOr<void>> _onTicketsErrorShown(
    TicketsErrorShown event,
    Emitter<TicketsState> emit,
  ) async {
    emit(state.copyWithNullError());
  }
}
