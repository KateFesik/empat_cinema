part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent extends Equatable {}

class InitMovies extends MoviesEvent {
  final DateTime date;

  InitMovies({
    required this.date,
  });

  @override
  List<Object?> get props => [date];
}

class OnErrorShown extends MoviesEvent {
  @override
  List<Object?> get props => List.empty();
}

