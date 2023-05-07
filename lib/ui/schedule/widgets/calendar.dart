import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Calendar extends StatelessWidget {
  final DateTime selectedDate;
  final List<DateTime> dates;
  final ValueChanged<DateTime> onClick;

  const Calendar({
    Key? key,
    required this.selectedDate,
    required this.dates,
    required this.onClick,
  }) : super(key: key);

  bool _isSameDate(DateTime currentDate, BuildContext context) {
    return (currentDate.day == selectedDate.day &&
        currentDate.month == selectedDate.month);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ...dates
              .map(
                (dateTime) => GestureDetector(
                  onTap: () {
                    onClick(dateTime);
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      children: [
                        Text(
                          DateFormat.E().format(dateTime),
                          style: Theme.of(context)
                              .textTheme
                              .labelLarge!
                              .copyWith(
                                  color: _isSameDate(dateTime, context)
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                        ),
                        Text(
                          DateFormat('dd.MM').format(dateTime),
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(
                                  color: _isSameDate(dateTime, context)
                                      ? Theme.of(context).colorScheme.primary
                                      : Theme.of(context)
                                          .colorScheme
                                          .onSurface),
                        ),
                      ],
                    ),
                  ),
                ),
              )
              .toList(),
        ],
      ),
    );
  }
}
