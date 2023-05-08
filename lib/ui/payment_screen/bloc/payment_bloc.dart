import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

import '../../../data/network/cinema_rest_client.dart';

part 'payment_event.dart';

part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  final CinemaRestClient client;
  final int sessionId;
  final List<int> seatIds;
  final double totalPrice;

  PaymentBloc(
    this.client,
    this.sessionId,
    this.seatIds,
    this.totalPrice,
  ) : super(PaymentState(
          sessionId: sessionId,
          seatIds: seatIds,
          totalPrice: 0.0,
          loading: false,
          errorMessage: null,
        )) {
    on<OnErrorShown>(_onErrorShown);
    on<OnOrder>(_onOrder);
  }

  Future<void> _onOrder(
    OnOrder event,
    Emitter<PaymentState> emit,
  ) async {
    final email = event.email.replaceAll(' ', '');
    final cardNumber = event.cardNumber.replaceAll(' ', '');
    final expirationDate = event.expirationDate;
    final cvv = event.cvv;
    if (!_isValidData(cardNumber, expirationDate, cvv)) {
      emit(state.copyWith(
        loading: false,
        errorMessage: "Incorrect data",
      ));
      return;
    }

    logMessage("order tickets");
    try {
      emit(state.copyWith(
        loading: true,
      ));
      bool ordered = await client.orderTickets(
          sessionId, seatIds, email, cardNumber, expirationDate, cvv);
      if (ordered) {
        emit(state.copyWith(
          loading: false,
          ordered: ordered,
        ));
      } else {
        emit(state.copyWith(
          loading: false,
          errorMessage: "Unable to order tickets",
        ));
      }
    } catch (e) {
      logWarning(e.toString());
      emit(state.copyWith(
        loading: false,
        errorMessage: "Something went wrong",
      ));
    }
  }

  bool _isValidData(
    String cardNumber,
    String expirationDate,
    String cvv,
  ) {
    if (cvv.length != 3) {
      return false;
    }
    if (expirationDate.length != 5) {
      return false;
    }
    if (cardNumber.length != 16) {
      return false;
    }
    return true;
  }

  Future<FutureOr<void>> _onErrorShown(
    OnErrorShown event,
    Emitter<PaymentState> emit,
  ) async {
    emit(state.copyWithNullError());
  }
}
