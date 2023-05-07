import 'package:flutter/material.dart';

class CinemaHallCard extends StatelessWidget {
  final double totalPrice;
  final String roomName;
  final Widget seatsWidget;
  final Widget legendWidget;

  const CinemaHallCard({
    Key? key,
    required this.totalPrice,
    required this.roomName,
    required this.seatsWidget,
    required this.legendWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text(
                "room:  $roomName",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Text("Total price: $totalPrice UAH"),
            ),
            Expanded(
              child: seatsWidget,
            ),
            const SizedBox(
              height: 20.0,
            ),
            legendWidget,
          ],
        ),
      ),
    );
  }
}

//   @override
//   Widget build(BuildContext context) {
//     return LayoutBuilder(builder: (context, constraintType) {
//       final double maxWidth = constraintType.maxWidth;
//       final double maxHeight = constraintType.maxHeight;
//       final CinemaHallSize cinemaHall = _getCinemaHall(maxWidth, maxHeight);
//       return Card(
//         child: SizedBox(
//           width: double.infinity,
//           child: Column(
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text(
//                   "room: ${session.room.name} ",
//                   style: Theme.of(context).textTheme.titleLarge,
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Text(
//                     "Total price:  ${context.read<SessionBloc>().state.totalPrice} UAH"),
//               ),
//               Expanded(
//                 child: CinemaSeats(
//                   cinemaHallSize: cinemaHall,
//                   rows: session.room.rows,
//                 ),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               LegendWidget(
//                 seatSize: cinemaHall.seatSize,
//               ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }
