import 'package:cinema/ui/cinema_root.dart';
import 'package:flutter/material.dart';

class CinemaBottomAppBar extends StatelessWidget {
  final RootTab tab;
  final ValueChanged<RootTab> onTap;

  const CinemaBottomAppBar({
    Key? key,
    required this.tab,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      currentIndex: tab.index,
      onTap: (index) {
        onTap(RootTab.values[index]);
      },
      showSelectedLabels: true,
      showUnselectedLabels: true,
      items: RootTab.values
          .map((entry) => BottomNavigationBarItem(
                icon: Icon(entry.icon),
                label: entry.name,
              ))
          .toList(),
    );
  }
}
