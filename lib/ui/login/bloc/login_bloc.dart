import 'dart:async';

import 'package:cinema/data/account/account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/account/token_cache.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final TokenCache tokenCache;
  final AccountRepository repository;

  LoginBloc(
    this.tokenCache,
    this.repository,
  ) : super(const LoginState(
          phone: null,
          loading: false,
          errorMessage: null,
          isOtpSent: false,
        )) {
    on<LoginAnonymousPressed>(_onLoginAnonymousPressed);
    on<LoginPhoneSubmitted>(_onLoginPhoneSubmitted);
    on<LoginOtpSubmitted>(_onLoginOtpSubmitted);
    on<LoginErrorShown>(_onLoginErrorShown);
  }

  Future<FutureOr<void>> _onLoginAnonymousPressed(
    LoginAnonymousPressed event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(
        loading: true,
      ));
      await repository.anonymousLogin();
      emit(state.copyWith(loading: false));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: "Something went wrong",
      ));
    }
  }

  Future<FutureOr<void>> _onLoginPhoneSubmitted(
    LoginPhoneSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(
        loading: true,
        phone: event.phone,
      ));
      await repository.sendOtp(event.phone);

      emit(state.copyWith(
        loading: false,
        isOtpSent: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: "Something went wrong",
      ));
    }
  }

  Future<FutureOr<void>> _onLoginOtpSubmitted(
    LoginOtpSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    try {
      emit(state.copyWith(
        loading: true,
      ));
      await repository.otpLogin(state.phone!, "0000");
      emit(state.copyWith(loading: false));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        errorMessage: "Something went wrong",
      ));
    }
  }

  Future<FutureOr<void>> _onLoginErrorShown(
      LoginErrorShown event,
      Emitter<LoginState> emit,
      ) async {
    emit(state.copyWith(
      errorMessage: null,
    ));
  }
}
