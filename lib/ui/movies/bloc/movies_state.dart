part of 'movies_bloc.dart';

@immutable
class MoviesState extends Equatable {
  final List<Movie> movies;
  final bool loading;
  final String? errorMessage;

  const MoviesState({
    required this.movies,
    required this.loading,
    required this.errorMessage,
  });

  MoviesState copyWith({
    List<Movie>? movies,
    bool? loading,
    String? errorMessage,
  }) {
    return MoviesState(
      movies: movies ?? this.movies,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        movies,
        loading,
        errorMessage,
      ];
}
