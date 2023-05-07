import 'package:flutter/material.dart';

import '../account/account_screen.dart';

class CinemaAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CinemaAppBar({
    Key? key,
  }) : super(key: key);

  final String _title = "Empat Cinema";

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  void _openAccountScreen(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return const AccountScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Text(
        _title,
      ),
      titleSpacing: 20.0,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.search,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: const Icon(
            Icons.account_circle_outlined,
          ),
          onPressed: () {
            _openAccountScreen(context);
          },
        ),
      ],
    );
  }
}
