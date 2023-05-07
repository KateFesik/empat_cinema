import 'package:cinema/ui/movie_details/widgets/main_movie_info.dart';
import 'package:cinema/ui/movie_details/widgets/movie_details_sliver.dart';
import 'package:flutter/material.dart';

import '../../data/network/model/movie.dart';
import '../schedule/widgets/schedule_widget.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;
  final DateTime selectedDate;

  const MovieDetailsScreen({
    Key? key,
    required this.movie,
    required this.selectedDate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            MovieDetailsSliver(movie: movie),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  ScheduleWidget(
                    movie: movie,
                    selectedDate: selectedDate,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  MainMovieInfo(
                    movie: movie,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
