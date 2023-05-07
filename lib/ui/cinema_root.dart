import 'package:cinema/ui/tickets/tickets_screen.dart';
import 'package:flutter/material.dart';

import 'common/cinema_app_bar.dart';
import 'common/cinema_bottom_app_bar.dart';
import 'movies/movies_screen.dart';

class CinemaRoot extends StatefulWidget {
const CinemaRoot({Key? key,}) : super(key: key);

  @override
  State<CinemaRoot> createState() => CinemaRootState();
}

final GlobalKey<CinemaRootState> rootKey = GlobalKey<CinemaRootState>();

class CinemaRootState extends State<CinemaRoot> {
  int index = 0;

  void setIndex(int index) {
    setState(() {
      this.index = index;
    });
  }

  Widget getCurrentScreen(int index) {
    switch (index) {
      case 0:
        return const MoviesScreen();
      case 1:
        return const TicketsScreen();
      default:
        return const MoviesScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CinemaAppBar(),
      body: getCurrentScreen(index),
      bottomNavigationBar: CinemaBottomAppBar(
        index: index,
        onTap: (index) {
          setState(() {
            this.index = index;
          });
        },
      ),
    );
  }
}
