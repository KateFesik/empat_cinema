import 'dart:async';

import 'package:cinema/data/account/account_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

part 'account_event.dart';

part 'account_state.dart';

class AccountBloc extends Bloc<AccountEvent, AccountState> {
  final AccountRepository repository;

  AccountBloc(
    this.repository,
  ) : super(const AccountState(
          phone: null,
          name: null,
          loading: true,
          errorMessage: null,
        )) {
    on<InitAccount>(_onInitAccount);
    on<SaveName>(_onSaveName);
  }

  Future<FutureOr<void>> _onInitAccount(
    InitAccount event,
    Emitter<AccountState> emit,
  ) async {
    logMessage("init account");
    try {
      emit(state.copyWith(
        loading: true,
      ));
      final accountInfo = await repository.getAccountInfo();
      emit(state.copyWith(
        loading: false,
        phone: accountInfo.phoneNumber,
        name: accountInfo.name,
      ));
    } catch (e) {
      logWarning(e.toString());
      emit(state.copyWith(
        loading: false,
        errorMessage: "Something went wrong",
      ));
    }
  }

  Future<FutureOr<void>> _onSaveName(
    SaveName event,
    Emitter<AccountState> emit,
  ) async {
    logMessage("save name");
    try {
      final accountInfo = await repository.saveName(event.name);
      emit(state.copyWith(
        loading: false,
        phone: accountInfo.phoneNumber,
        name: accountInfo.name,
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
