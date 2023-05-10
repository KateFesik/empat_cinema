import 'package:cinema/data/network/model/session.dart';
import 'package:cinema/ui/common/cinema_button.dart';
import 'package:cinema/ui/payment_screen/payment_screen.dart';
import 'package:cinema/ui/session/widgets/cinema_hall_card.dart';
import 'package:cinema/ui/session/widgets/cinema_seats.dart';
import 'package:cinema/ui/session/widgets/legend.dart';
import 'package:cinema/ui/session/widgets/session_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/network/cinema_rest_client.dart';
import '../../data/network/model/seat.dart';
import '../common/loading_overlay.dart';
import '../common/session_text_date.dart';
import 'bloc/session_bloc.dart';

const String _buttonText = "book";

class SessionScreen extends StatelessWidget {
  final String movieName;
  final Session session;

  const SessionScreen({
    Key? key,
    required this.session,
    required this.movieName,
  }) : super(key: key);

  void _openPaymentScreen(
    BuildContext context,
    List<Seat> selectedSeats,
    String movieName,
    double totalPrice,
    Session session,
  ) async {
    List<int> seatIds = selectedSeats.map((e) => e.id).toList();
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
          return PaymentScreen(
            seatIds: seatIds,
            session: session,
            movieName: movieName,
            totalPrice: totalPrice,
          );
        },
      ),
    );
    context.read<SessionBloc>().add(SessionStarted());
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionBloc>(
      create: (context) => SessionBloc(
        context.read<CinemaRestClient>(),
        session,
      )..add(SessionStarted()),
      child: Scaffold(
        appBar: SessionAppBar(
          title: movieName,
        ),
        body: BlocConsumer<SessionBloc, SessionState>(
          listener: (BuildContext context, SessionState state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(SnackBar(
                  content: Text(state.errorMessage!),
                ));
              context.read<SessionBloc>().add(SessionErrorShown());
            }
            if (state.booked) {
              context.read<SessionBloc>().add(SessionNavigationHandled());
              _openPaymentScreen(
                context,
                state.selectedSeats,
                movieName,
                state.totalPrice,
                state.session,
              );
            }
          },
          builder: (BuildContext context, SessionState state) {
            return LoadingOverlay(
              loading: state.loading,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: SessionTextDate(session: state.session),
                  ),
                  Expanded(
                    child: CinemaHallCard(
                      totalPrice: state.totalPrice,
                      roomName: state.session.room.name,
                      seatsWidget: CinemaSeats(
                          seatRows: state.session.room.rows,
                          selectedSeats: state.selectedSeats,
                          onTap: (seat) {
                            context
                                .read<SessionBloc>()
                                .add(SessionSeatSelected(seat: seat));
                          }),
                      legendWidget: LegendButton(
                        seatsPrice: state.seatsPrice,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    child: CinemaButton(
                      isDisabled: (state.selectedSeats.isEmpty),

                      title: _buttonText,
                      onTap: () {
                        context.read<SessionBloc>().add(SessionTicketsBooked());
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
