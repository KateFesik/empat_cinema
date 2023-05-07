import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'widgets/day_movies_page.dart';

class MoviesScreen extends StatefulWidget {
  const MoviesScreen({Key? key}) : super(key: key);

  @override
  State<MoviesScreen> createState() => _MoviesScreenState();
}

class _MoviesScreenState extends State<MoviesScreen>
    with TickerProviderStateMixin {
  late final TabController tabController;
  late List<DateTime> dates;

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 5, vsync: this);
    dates = List.generate(tabController.length, (index) => _getData(index));
  }

  DateTime _getData(int index) {
    return DateTime.now().add(Duration(days: index));
  }

  @override
  void dispose() {
    super.dispose();
    tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        TabBar(
          isScrollable: true,
          controller: tabController,
          tabs: dates
              .map((dateTime) => Tab(
                    child: Column(
                      children: [
                        Text(
                          DateFormat.E().format(dateTime),
                        ),
                        Text(
                          DateFormat('dd.MM').format(dateTime),
                        ),
                      ],
                    ),
                  ))
              .toList(),
        ),
        Expanded(
          child: TabBarView(
            controller: tabController,
            children: dates.map((dateTime) {
              return DayMoviesPage(
                date: dateTime,
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
