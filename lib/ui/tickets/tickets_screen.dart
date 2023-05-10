import 'package:cinema/ui/tickets/widgets/no_tickets.dart';
import 'package:cinema/ui/tickets/widgets/purchase_tickets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/network/cinema_rest_client.dart';
import '../common/loading_overlay.dart';
import 'bloc/tickets_bloc.dart';

class TicketsScreen extends StatelessWidget {
  const TicketsScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TicketsBloc>(
      create: (context) => TicketsBloc(
        context.read<CinemaRestClient>(),
      )..add(TicketsStarted()),
      child: Scaffold(
        body: BlocConsumer<TicketsBloc, TicketsState>(
          listener: (BuildContext context, TicketsState state) {
            if (state.errorMessage != null) {
              ScaffoldMessenger.of(context)
                ..clearSnackBars()
                ..showSnackBar(SnackBar(
                  content: Text(state.errorMessage!),
                ));
              context.read<TicketsBloc>().add(TicketsErrorShown());
            }
          },
          builder: (BuildContext context, TicketsState state) {
            return LoadingOverlay(
              loading: state.loading,
              child: state.tickets.isNotEmpty
                  ? PurchaseTickets(
                      tickets: state.tickets,
                    )
                  : const NoTickets(),
            );
          },
        ),
      ),
    );
  }
}
