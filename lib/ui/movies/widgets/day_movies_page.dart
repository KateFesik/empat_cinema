import 'package:cinema/data/network/cinema_rest_client.dart';
import 'package:cinema/ui/common/loading_overlay.dart';
import 'package:cinema/ui/movies/bloc/movies_bloc.dart';
import 'package:cinema/ui/movies/widgets/movie_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../data/network/model/movie.dart';
import '../../movie_details/movie_details_screen.dart';

class DayMoviesPage extends StatefulWidget {
  final DateTime date;

  const DayMoviesPage({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  State<DayMoviesPage> createState() => _DayMoviesPageState();
}

class _DayMoviesPageState extends State<DayMoviesPage>
    with AutomaticKeepAliveClientMixin<DayMoviesPage> {
  @override
  bool get wantKeepAlive => true;

  void _openFilmScreen(BuildContext context, Movie movie) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MovieDetailsScreen(
            movie: movie,
            selectedDate: widget.date,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return BlocProvider<MoviesBloc>(
      create: (context) {
        return MoviesBloc(
          context.read<CinemaRestClient>(),
        )..add(InitMovies(date: widget.date));
      },
      child: Scaffold(
        body: BlocConsumer<MoviesBloc, MoviesState>(
          listener: (BuildContext context, MoviesState state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(SnackBar(
                  content: Text(state.errorMessage!),
                ));
              context.read<MoviesBloc>().add(OnErrorShown());
            }
          },
          builder: (BuildContext context, MoviesState state) {
            return LoadingOverlay(
              loading: state.loading,
              child: GridView.count(
                crossAxisCount: 2,
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
                childAspectRatio: 0.7,
                children: state.movies.map((entry) {
                  return Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: MovieItem(
                      movie: entry,
                      onItemTap: (value) {
                        _openFilmScreen(context, value);
                      },
                    ),
                  );
                }).toList(),
              ),
            );
          },
        ),
      ),
    );
  }
}
