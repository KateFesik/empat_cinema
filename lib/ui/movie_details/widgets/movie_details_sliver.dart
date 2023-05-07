import 'package:flutter/material.dart';

import '../../../data/network/model/movie.dart';
import '../../common/shadow_mask.dart';

class MovieDetailsSliver extends StatelessWidget {
  final Movie movie;

  const MovieDetailsSliver({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text(
        movie.name,
        style: Theme
            .of(context)
            .textTheme
            .headlineSmall!
            .copyWith(
          color: Colors.white,
          overflow: TextOverflow.fade,
        ),
      ),
      expandedHeight: 500.0,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(movie.image),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topCenter,
                child: ShadowTopMask(
                  child: Container(),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: ShadowBottomMask(
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.white,
                          size: 36.0,
                        ),
                        const SizedBox(width: 8.0,),
                        Text(
                          movie.rating,
                          textAlign: TextAlign.center,
                          style: Theme
                              .of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(
                            color: Colors.white,
                            overflow: TextOverflow.fade,
                          ),
                        ),
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.favorite_border,
                            color: Colors.white,
                            size: 36.0,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
