part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent extends Equatable {}

class ScheduleStarted extends ScheduleEvent {
  final DateTime date;

  ScheduleStarted({
    required this.date,
  });

  ScheduleStarted copyWith({
    DateTime? date,
  }) {
    return ScheduleStarted(
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [date];
}
