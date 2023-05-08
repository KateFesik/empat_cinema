import 'package:flutter/material.dart';

import '../../cinema_root.dart';

class NoTickets extends StatelessWidget {
  const NoTickets({
    Key? key,
  }) : super(key: key);

  final String _message = "You don't have any tickets yet...";
  final String _buttonText = "NOW BOOKING";

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const SizedBox(
            height: 200.0,
          ),
          Text(
            _message,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(
            height: 20.0,
          ),
          SizedBox(
            width: 300.0,
            child: ElevatedButton(
              onPressed: () {
                rootKey.currentState?.setActiveTab(RootTab.movies);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14.0),
                child: Text(
                  _buttonText,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
