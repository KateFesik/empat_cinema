import 'dart:async';

import 'package:cinema/data/account/account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'app_event.dart';

part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AccountRepository repository;

  AppBloc(this.repository)
      : super(const AppState(
          authenticationState: AuthenticationState.started,
          authenticationType: AuthenticationType.anonymousLogin,
        )) {
    repository.accessTokenStream().listen((accessToken) {
      if (accessToken == null) {
        add(AppLoggedOut());
      } else {
        add(AppLoggedIn());
      }
    });

    on<AppLoggedOut>(_onAppLoggedOut);
    on<AppLoggedIn>(_onAppLoggedIn);
  }

  FutureOr<void> _onAppLoggedOut(AppLoggedOut event, Emitter<AppState> emit) {
    final authenticationType = repository.getAuthenticationType();
    emit(AppState(
      authenticationState: AuthenticationState.loginRequired,
      authenticationType: authenticationType,
    ));
  }

  FutureOr<void> _onAppLoggedIn(AppLoggedIn event, Emitter<AppState> emit) {
    final authenticationType = repository.getAuthenticationType();
    emit(AppState(
      authenticationState: AuthenticationState.authenticated,
      authenticationType: authenticationType,
    ));
  }
}
