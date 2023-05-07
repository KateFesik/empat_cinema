part of 'schedule_bloc.dart';

@immutable
abstract class ScheduleEvent extends Equatable {}

class InitSchedule extends ScheduleEvent {
  final DateTime date;

  InitSchedule({
    required this.date,
  });

  InitSchedule copyWith({
    DateTime? date,
  }) {
    return InitSchedule(
      date: date ?? this.date,
    );
  }

  @override
  List<Object?> get props => [date];
}
