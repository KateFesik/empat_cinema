import 'package:flutter/material.dart';

const _menuItems = {
  "Movies": Icons.movie,
  "Tickets": Icons.confirmation_num_outlined,
};

class CinemaBottomAppBar extends StatelessWidget {
  final int index;
  final ValueChanged<int> onTap;

  const CinemaBottomAppBar({
    Key? key,
    required this.index,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: index,
      onTap: onTap,
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: _menuItems.entries
          .map((entry) => BottomNavigationBarItem(
        icon: Icon(entry.value),
        label: entry.key,
      ))
          .toList(),
    );
  }
}