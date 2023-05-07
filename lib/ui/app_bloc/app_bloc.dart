import 'dart:async';

import 'package:cinema/data/account/account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AccountRepository accountRepository;

  AppBloc(this.accountRepository)
      : super(const AppState(AuthenticationState.initial)) {
    accountRepository.accessTokenStream().listen((accessToken) {
      if (accessToken == null) {
        add(OnLoggedOut());
      } else {
        add(OnLoggedIn());
      }
    });

    on<OnLoggedOut>(_onLoggedOut);
    on<OnLoggedIn>(_onLoggedIn);
  }

  @override
  void onChange(Change<AppState> change) {
    super.onChange(change);
   }

  FutureOr<void> _onLoggedOut(OnLoggedOut event, Emitter<AppState> emit) {
    emit(const AppState(AuthenticationState.loginRequired));
  }

  FutureOr<void> _onLoggedIn(OnLoggedIn event, Emitter<AppState> emit) {
    emit(const AppState(AuthenticationState.authenticated));
  }
}


