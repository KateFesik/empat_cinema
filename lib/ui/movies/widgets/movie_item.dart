import 'package:cinema/data/network/model/movie.dart';
import 'package:flutter/material.dart';

import '../../common/shadow_mask.dart';
import '../../movie_details/movie_details_screen.dart';

class MovieItem extends StatelessWidget {
  final Movie movie;
  final ValueChanged<Movie> onItemTap;

  const MovieItem({
    super.key,
    required this.movie, required this.onItemTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onItemTap(movie);
      },
      child: SizedBox(
        height: 200.0,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(movie.smallImage),
              fit: BoxFit.cover,
            ),
          ),
          child: ShadowBottomMask(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  movie.name,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: Colors.white,
                        overflow: TextOverflow.fade,
                      ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
