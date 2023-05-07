import 'package:cinema/data/network/model/session.dart';
import 'package:cinema/ui/common/cinema_button.dart';
import 'package:cinema/ui/session/widgets/cinema_hall_card.dart';
import 'package:cinema/ui/session/widgets/cinema_seats.dart';
import 'package:cinema/ui/session/widgets/legend.dart';
import 'package:cinema/ui/session/widgets/session_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../data/network/cinema_rest_client.dart';
import '../common/loading_overlay.dart';
import 'bloc/session_bloc.dart';

const String buttonText = "book";

class SessionScreen extends StatelessWidget {
  final Session session;
  final String movieName;

  const SessionScreen({
    Key? key,
    required this.session,
    required this.movieName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SessionBloc>(
      create: (context) => SessionBloc(
        context.read<CinemaRestClient>(),
        session.id,
      )..add(InitSession(rows: session.room.rows)),
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
              context.read<SessionBloc>().add(OnErrorShown());
            }
            if (state.booked) {
              context.read<SessionBloc>().add(OnNavigationHandledEvent());
              // Navigator.push(context, route)
            }
          },
          builder: (BuildContext context, SessionState state) {
            return LoadingOverlay(
              loading: state.loading,
              child: Column(
                children: [
                  SessionTextDate(session: session),
                  Expanded(
                    child: CinemaHallCard(
                      totalPrice: state.totalPrice,
                      roomName: session.room.name,
                      seatsWidget: CinemaSeats(
                          seatRows: session.room.rows,
                          selectedSeats: state.selectedSeats,
                          onTap: (seat) {
                            context
                                .read<SessionBloc>()
                                .add(OnSeatSelected(seat: seat));
                          }),
                      legendWidget: LegendWidget(
                        seatsPrice: state.seatsPrice,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0,),
                    child: CinemaButton(
                      title: buttonText,
                      onTap: () {//todo
                        context.read<SessionBloc>().add(OnBookTickets());
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

class SessionTextDate extends StatelessWidget {
  final Session session;

  const SessionTextDate({
    super.key,
    required this.session,
  });

  String _convertDate(DateTime date) {
    return "${DateFormat.EEEE().format(date)}, "
        "${DateFormat('HH:mm').format(date)}";
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(
          "${_convertDate(session.date)} - ${session.type}",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
                color: Theme.of(context).colorScheme.primary,
              ),
        ),
      ),
    );
  }
}
