import 'package:cinema/ui/tickets/tickets_screen.dart';
import 'package:flutter/material.dart';

import 'common/cinema_app_bar.dart';
import 'common/cinema_bottom_app_bar.dart';
import 'movies/movies_screen.dart';

class CinemaRoot extends StatefulWidget {
  const CinemaRoot({
    Key? key,
  }) : super(key: key);

  @override
  State<CinemaRoot> createState() => CinemaRootState();
}

final GlobalKey<CinemaRootState> rootKey = GlobalKey<CinemaRootState>();

enum RootTab {
  movies("Movies", Icons.movie),
  tickets("Tickets", Icons.confirmation_num_outlined);

  final String name;
  final IconData icon;

  const RootTab(this.name, this.icon);
}

class CinemaRootState extends State<CinemaRoot> {
  RootTab activeTab = RootTab.movies;

  void setActiveTab(RootTab tab) {
    setState(() {
      activeTab = tab;
    });
  }

  Widget getCurrentScreen(RootTab rootTab) {
    switch (rootTab) {
      case RootTab.movies:
        return const MoviesScreen();
      case RootTab.tickets:
        return const TicketsScreen();
      default:
        return const MoviesScreen();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CinemaAppBar(),
      body: getCurrentScreen(activeTab),
      bottomNavigationBar: CinemaBottomAppBar(
        tab: activeTab,
        onTap: (tab) {
          setActiveTab(tab);
        },
      ),
    );
  }
}
