import 'dart:async';

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
  final int sessionId;

  SessionBloc(
    this.client,
    this.sessionId,
  ) : super(SessionState(
          sessionId: sessionId,
          seatsPrice: List.empty(),
          selectedSeats: List.empty(),
          totalPrice: 0.0,
          loading: false,
          errorMessage: null,
        )) {
    on<InitSession>(_onInitSession);
    on<OnErrorShown>(_onErrorShown);
    on<OnSeatSelected>(_onSeatSelected);
    on<OnBookTickets>(_onBookTickets);
    on<OnNavigationHandledEvent>(_onNavigationHandledEvent);
  }

  Future<FutureOr<void>> _onInitSession(
    InitSession event,
    Emitter<SessionState> emit,
  ) async {
    final List<Seat> seatsPrice = [];
    for (final type in SeatType.values) {
      final Seat seat = Seat(
        id: type.index + 1,
        index: type.index + 1,
        type: type,
        price: _getSeatPrice(
          type,
          event.rows,
        ),
        isAvailable: true,
      );
      if (seat.price != -1) {
        seatsPrice.add(seat);
      }
    }

    emit(state.copyWith(
      seatsPrice: seatsPrice,
    ));
  }

  Future<FutureOr<void>> _onErrorShown(
    OnErrorShown event,
    Emitter<SessionState> emit,
  ) async {
    emit(state.copyWith(
      errorMessage: null,
    ));
  }

  Future<FutureOr<void>> _onSeatSelected(
    OnSeatSelected event,
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

  double _getSeatPrice(SeatType type, List<SeatRow> rows) {
    return rows
            .expand((seatRow) => seatRow.seats)
            .firstWhereOrNull((seat) => seat.type == type)
            ?.price ??
        -1;
  }

  Future<FutureOr<void>> _onBookTickets(
    OnBookTickets event,
    Emitter<SessionState> emit,
  ) async {
    logMessage("book tickets");
    try {
      emit(state.copyWith(
        loading: true,
      ));
      List<int> tickets = state.selectedSeats.map((e) => e.id).toList();
      logMessage(tickets.toString());
      bool booked = await client.reservation(sessionId, tickets);

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

  Future<FutureOr<void>> _onNavigationHandledEvent(
      OnNavigationHandledEvent event,
      Emitter<SessionState> emit,
      ) async {
    emit(state.copyWith(
      booked: false,
    ));
  }
}
