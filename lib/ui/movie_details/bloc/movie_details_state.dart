part of 'movie_details_bloc.dart';

@immutable
class MovieDetailsState extends Equatable {
  final Movie movie;
  final bool loading;
  final String? errorMessage;

  const MovieDetailsState({
    required this.movie,
    required this.loading,
    this.errorMessage,
  });

  MovieDetailsState copyWith({
    Movie? movie,
    bool? loading,
    String? errorMessage,
  }) {
    return MovieDetailsState(
      movie: movie ?? this.movie,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        movie,
        loading,
        errorMessage,
      ];
}
