import 'package:cinema/ui/tickets/widgets/qr_code.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lumberdash/lumberdash.dart';

import '../../../data/network/model/ticket.dart';

class PurchaseTickets extends StatelessWidget {
  final Map<String, List<Ticket>> tickets;

  const PurchaseTickets({
    Key? key,
    required this.tickets,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: tickets.entries
          .map((entry) => SessionTickets(
                tickets: entry.value,
              ))
          .toList(),
    );
  }
}

class SessionTickets extends StatelessWidget {
  final List<Ticket> tickets;

  const SessionTickets({
    Key? key,
    required this.tickets,
  }) : super(key: key);

  String _convertDate(DateTime date) {
    return DateFormat("EEEE dd.MM 'at' HH:mm").format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: SizedBox(
          height: 200.0,
          width: double.infinity,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(tickets.first.image),
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Stack(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            tickets.first.name,
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge!
                                .copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            _convertDate(tickets.first.date),
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 8.0),
                          Text(
                            'Seats: ${tickets.length}',
                            style: Theme.of(context).textTheme.titleSmall,
                          ),
                        ],
                      ),
                      Align(
                          alignment: Alignment.bottomRight,
                          child: QrCodeButton(
                            tickets: tickets,
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
