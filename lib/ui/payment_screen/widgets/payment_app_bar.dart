import 'package:flutter/material.dart';

import '../../cinema_root.dart';

const _title = "Purchase the tickets";

class PaymentAppBar extends StatelessWidget implements PreferredSizeWidget {
  const PaymentAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: true,
      title: const Text(
        _title,
      ),
      titleSpacing: 0,
    );
  }
}
