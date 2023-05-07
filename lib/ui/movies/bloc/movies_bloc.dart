import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumberdash/lumberdash.dart';

import '../../../data/network/cinema_rest_client.dart';
import '../../../data/network/model/movie.dart';

part 'movies_event.dart';

part 'movies_state.dart';

class MoviesBloc extends Bloc<MoviesEvent, MoviesState> {
  final CinemaRestClient client;

  MoviesBloc(
    this.client,
  ) : super(MoviesState(
          movies: List.empty(),
          loading: true,
          errorMessage: null,
        )) {
    on<InitMovies>(_onInitMovies);
    on<OnErrorShown>(_onErrorShown);
  }

  Future<FutureOr<void>> _onInitMovies(
    InitMovies event,
    Emitter<MoviesState> emit,
  ) async {
    logMessage("init movies");
    try {
      emit(state.copyWith(
        loading: true,
      ));
      final movies = await client.searchMovies(
        date: event.date,
      );
      emit(state.copyWith(
        loading: false,
        movies: movies,
      ));
    } catch (e) {
      logWarning(e.toString());
      emit(state.copyWith(
        loading: false,
        errorMessage: "Something went wrong",
      ));
    }
  }

  Future<FutureOr<void>> _onErrorShown(
      OnErrorShown event,
      Emitter<MoviesState> emit,
      ) async {
    emit(state.copyWith(
      errorMessage: null,
    ));
  }
}
