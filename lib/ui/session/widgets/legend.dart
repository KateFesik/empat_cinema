import 'package:flutter/material.dart';

import '../../../data/network/model/seat.dart';
import 'cinema_seats.dart';

const String _legend = "LEGEND";
const String _legendTitle = "The seats:";

class LegendWidget extends StatelessWidget {
  final List<Seat> seatsPrice;

  const LegendWidget({
    super.key,
    required this.seatsPrice,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: TextButton(
        onPressed: () => showDialog<String>(
          context: context,
          builder: (BuildContext context) =>
              LegendAlertDialog(seatsPrice: seatsPrice),
        ),
        child: const LegendButton(),
      ),
    );
  }
}

class LegendAlertDialog extends StatelessWidget {
  final List<Seat> seatsPrice;

  const LegendAlertDialog({
    super.key,
    required this.seatsPrice,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(_legendTitle),
      content: Table(
        // defaultColumnWidth: const IntrinsicColumnWidth(),
        // columnWidths: const {
        //   0: FixedColumnWidth(46),
        //   1: FlexColumnWidth(),
        // },
        columnWidths: const {
          0: IntrinsicColumnWidth(),
          1: FlexColumnWidth(10),
        },
        children: [
          ...seatsPrice
              .map(
                (seat) => TableRow(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),

                        child: SeatItem(
                          size: 26.0,
                          seat: seat,
                          selected: false,
                        ),

                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        "${seat.type.displayableName} ${seat.price.toString()} UAH",
                      ),
                    ),
                  ],
                ),
              )
              .toList(),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context, 'OK'),
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class LegendButton extends StatelessWidget {
  const LegendButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          _legend,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        const SizedBox(
          width: 10.0,
        ),
        Icon(
          Icons.remove_red_eye_outlined,
          color: Theme.of(context).colorScheme.onSurface,
          size: 24.0,
        ),
      ],
    );
  }
}
