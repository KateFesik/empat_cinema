part of 'movies_bloc.dart';

@immutable
abstract class MoviesEvent extends Equatable {}

class MoviesStarted extends MoviesEvent {
  final DateTime date;

  MoviesStarted({
    required this.date,
  });

  @override
  List<Object?> get props => [date];
}

class MoviesErrorShown extends MoviesEvent {
  @override
  List<Object?> get props => List.empty();
}

