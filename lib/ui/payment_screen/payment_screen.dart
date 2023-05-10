import 'package:cinema/data/network/cinema_rest_client.dart';
import 'package:cinema/data/network/model/session.dart';
import 'package:cinema/ui/cinema_root.dart';
import 'package:cinema/ui/payment_screen/bloc/payment_bloc.dart';
import 'package:cinema/ui/payment_screen/widgets/payment_app_bar.dart';
import 'package:cinema/ui/payment_screen/widgets/payment_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../common/loading_overlay.dart';
import '../common/session_text_date.dart';

class PaymentScreen extends StatelessWidget {
  final List<int> seatIds;
  final Session session;
  final String movieName;
  final double totalPrice;

  const PaymentScreen({
    Key? key,
    required this.seatIds,
    required this.movieName,
    required this.totalPrice,
    required this.session,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PaymentBloc>(
      create: (context) => PaymentBloc(
        context.read<CinemaRestClient>(),
        session.id,
        seatIds,
        totalPrice,
      ),
      child: Scaffold(
        appBar: const PaymentAppBar(),
        body: BlocConsumer<PaymentBloc, PaymentState>(
          listener: (BuildContext context, PaymentState state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(SnackBar(
                  content: Text(state.errorMessage!),
                ));
              context.read<PaymentBloc>().add(PaymentErrorShown());
            }
            if (state.ordered) {
              Navigator.of(context).popUntil((route) {
                return route.isFirst;
              });
              rootKey.currentState?.setActiveTab(RootTab.tickets);
            }
          },
          builder: (BuildContext context, PaymentState state) {
            return LoadingOverlay(
              loading: state.loading,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  TicketsInfo(
                    totalPrice: totalPrice,
                    session: session,
                    movieName: movieName,
                  ),
                  const Expanded(
                    child: PaymentCard(),
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

class TicketsInfo extends StatelessWidget {
  final Session session;
  final String movieName;
  final double totalPrice;

  const TicketsInfo(
      {Key? key,
      required this.session,
      required this.movieName,
      required this.totalPrice})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Column(
          children: [
            Text(
              movieName,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
            SessionTextDate(session: session),
            Text(
              "Total price: $totalPrice",
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
