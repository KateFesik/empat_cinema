import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/network/cinema_rest_client.dart';
import '../../../data/network/model/movie.dart';

part 'movie_details_event.dart';

part 'movie_details_state.dart';

class MovieDetailsBloc extends Bloc<MovieDetailsEvent, MovieDetailsState> {
  final CinemaRestClient client;
  final Movie movie;

  MovieDetailsBloc(this.client,
      this.movie,) : super(MovieDetailsState(
    movie: movie,
    loading: false,
    errorMessage: null,
  ));
}
