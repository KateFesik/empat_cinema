import 'package:flutter/material.dart';

import '../../cinema_root.dart';

class SessionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const SessionAppBar({Key? key, required this.title,}) : super(key: key);


  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(
        title,
      ),
      titleSpacing: 0,
    );
  }
}
