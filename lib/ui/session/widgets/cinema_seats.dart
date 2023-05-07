import 'package:cinema/ui/theme/theme_data.dart';
import 'package:flutter/material.dart';

import '../../../data/network/model/seat.dart';
import '../../../data/network/model/seat_row.dart';

class CinemaSeats extends StatelessWidget {
  final List<SeatRow> seatRows;
  final List<Seat> selectedSeats;
  final ValueChanged<Seat> onTap;

  const CinemaSeats({
    Key? key,
    required this.seatRows,
    required this.selectedSeats,
    required this.onTap,
  }) : super(key: key);

  double _getSeatSize(double maxWidth, double maxHeight) {
    final int columnCount = seatRows.fold(
        0, (max, row) => row.seats.length > max ? row.seats.length : max);
    final double seatArea = 0.8 * maxWidth / (columnCount + 1);
    final double seatsOffset = seatArea * 0.1;
    return seatArea - seatsOffset;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final seatAreaSize = _getSeatSize(
          constraints.maxWidth,
          constraints.maxHeight,
        );
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: seatRows
              .map(
                (row) => SeatsRow(
                  index: row.index,
                  children: row.seats.map(
                    (seat) {
                      return InkWell(
                        onTap: seat.isAvailable ? () => onTap(seat) : null,
                        child: SeatItem(
                          size: seatAreaSize,
                          seat: seat,
                          selected: selectedSeats.contains(seat),
                        ),
                      );
                    },
                  ).toList(),
                ),
              )
              .toList(),
        );
      },
    );
  }
}

class SeatsRow extends StatelessWidget {
  final int index;
  final List<Widget> children;

  const SeatsRow({
    super.key,
    required this.index,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text((index).toString()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        ],
      ),
    );
  }
}

class SeatItem extends StatelessWidget {
  final double size;
  final Seat seat;
  final bool selected;

  const SeatItem({
    super.key,
    required this.size,
    required this.seat,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(size * 0.1),
      child: Container(
        decoration: BoxDecoration(
          color: getSeatColor(context),
          borderRadius: BorderRadius.circular(4.0),
        ),
        width: size * 0.9,
        height: size * 0.9,
        child: (seat.type == SeatType.vip)
            ? Icon(
          Icons.star,
          size: size * 0.7,
          color: Theme.of(context).colorScheme.onTertiary,
        )
            : Container(),
      ),
    );
  }

  Color getSeatColor(BuildContext context) {
    if (selected) {
      return Theme.of(context).colorScheme.onError;
    }
    Color seatColor;
    switch (seat.type) {
      case SeatType.normal:
        seatColor = Theme.of(context).colorScheme.primary;
        break;
      case SeatType.better:
      case SeatType.vip:
        seatColor = Theme.of(context).colorScheme.tertiary;
        break;
      default:
        seatColor = Theme.of(context).colorScheme.primary;
    }
    return seatColor.withDisabledOpacity(
      !seat.isAvailable,
    );
  }
}
