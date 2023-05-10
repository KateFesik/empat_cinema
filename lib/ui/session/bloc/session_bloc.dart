import 'dart:async';

import 'package:cinema/data/network/model/session.dart';
import 'package:collection/collection.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

import '../../../data/network/cinema_rest_client.dart';
import '../../../data/network/model/seat.dart';
import '../../../data/network/model/seat_row.dart';

part 'session_event.dart';

part 'session_state.dart';

class SessionBloc extends Bloc<SessionEvent, SessionState> {
  final CinemaRestClient client;
  final Session session;

  SessionBloc(
    this.client,
    this.session,
  ) : super(SessionState(
          sessionId: session.id,
          session: session,
          seatsPrice: List.empty(),
          selectedSeats: List.empty(),
          totalPrice: 0.0,
          loading: false,
          errorMessage: null,
        )) {
    on<SessionStarted>(_onSessionStarted);
    on<SessionErrorShown>(_onSessionErrorShown);
    on<SessionSeatSelected>(_onSessionSeatSelected);
    on<SessionTicketsBooked>(_onSessionTicketsBooked);
    on<SessionNavigationHandled>(_onSessionNavigationHandled);
  }

  Future<FutureOr<void>> _onSessionStarted(
    SessionStarted event,
    Emitter<SessionState> emit,
  ) async {
    logMessage("started session");
    try {
      emit(state.copyWith(
        loading: true,
      ));
      final session = await client.searchSession(state.sessionId);
      emit(state.copyWith(
        loading: false,
        session: session,
        seatsPrice: _generateSeatsPrice(session.room.rows),
        selectedSeats: List.empty(),
        booked: false,
      ));
    } catch (e) {
      logWarning(e.toString());
      emit(state.copyWith(
        loading: false,
        errorMessage: "Something went wrong",
      ));
    }
  }

  Future<FutureOr<void>> _onSessionErrorShown(
    SessionErrorShown event,
    Emitter<SessionState> emit,
  ) async {
    emit(state.copyWith(
      errorMessage: null,
    ));
  }

  Future<FutureOr<void>> _onSessionSeatSelected(
    SessionSeatSelected event,
    Emitter<SessionState> emit,
  ) async {
    final selectedSeats = List.of(state.selectedSeats);
    (selectedSeats.contains(event.seat))
        ? selectedSeats.remove(event.seat)
        : selectedSeats.add(event.seat);
    final totalPrice = selectedSeats.map((e) => e.price).sum;

    emit(state.copyWith(
      loading: false,
      selectedSeats: selectedSeats,
      totalPrice: totalPrice,
    ));
  }

  List<Seat> _generateSeatsPrice(List<SeatRow> rows) {
    final List<Seat> seatsPrice = [];
    for (final type in SeatType.values) {
      final Seat seat = Seat(
        id: type.index + 1,
        index: type.index + 1,
        type: type,
        price: _getSeatPrice(
          type,
          rows,
        ),
        isAvailable: true,
      );
      if (seat.price != -1) {
        seatsPrice.add(seat);
      }
    }
    return seatsPrice;
  }

  double _getSeatPrice(SeatType type, List<SeatRow> rows) {
    return rows
            .expand((seatRow) => seatRow.seats)
            .firstWhereOrNull((seat) => seat.type == type)
            ?.price ??
        -1;
  }

  Future<FutureOr<void>> _onSessionTicketsBooked(
    SessionTicketsBooked event,
    Emitter<SessionState> emit,
  ) async {
    logMessage("book tickets");
    try {
      emit(state.copyWith(
        loading: true,
      ));
      List<int> tickets = state.selectedSeats.map((e) => e.id).toList();
      bool booked = await client.reservation(state.sessionId, tickets);

      if (booked) {
        emit(state.copyWith(
          loading: false,
          booked: booked,
        ));
      } else {
        emit(state.copyWith(
          loading: false,
          errorMessage: "Unable to book tickets",
        ));
      }
    } catch (e) {
      logWarning(e.toString());
      emit(state.copyWith(
        loading: false,
        errorMessage: "Unable to book tickets",
      ));
    }
  }

  Future<FutureOr<void>> _onSessionNavigationHandled(
    SessionNavigationHandled event,
    Emitter<SessionState> emit,
  ) async {
    emit(state.copyWith(
      booked: false,
    ));
  }
}
