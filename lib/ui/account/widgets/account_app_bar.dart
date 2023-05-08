import 'package:flutter/material.dart';

import '../../cinema_root.dart';

class AccountAppBar extends StatelessWidget implements PreferredSizeWidget {
  const AccountAppBar({
    Key? key,
  }) : super(key: key);

  final String _title = "Account";

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: Text(
        _title,
      ),
      titleSpacing: 0,
      actions: [
        IconButton(
          icon: const Icon(
            Icons.confirmation_num_outlined,
          ),
          onPressed: () {
            Navigator.pop(context);
            rootKey.currentState?.setActiveTab(RootTab.tickets);
          },
        ),
      ],
    );
  }
}
