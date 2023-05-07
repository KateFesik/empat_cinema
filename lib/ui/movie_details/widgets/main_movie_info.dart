import 'package:cinema/data/network/model/movie.dart';
import 'package:cinema/ui/movie_details/widgets/trailer_widget.dart';
import 'package:flutter/material.dart';

import 'additional_movie_info.dart';

class MainMovieInfo extends StatelessWidget {
  final Movie movie;

  const MainMovieInfo({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          movie.name,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(
          height: 6.0,
        ),
        Text(
          movie.genre,
          style: Theme.of(context).textTheme.titleSmall,
        ),
        Text(
          "from ${movie.age} age old | ${movie.duration} minutes",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          height: 12.0,
        ),
        Text(
          movie.plot,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          height: 12.0,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TrailerWidget(
                videoUrl: movie.trailer,
              ),
              const SizedBox(
                width: 10.0,
              ),
              Expanded(
                child: AdditionalMovieInfo(
                  movie: movie,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
