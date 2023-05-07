part of 'schedule_bloc.dart';

@immutable
class ScheduleState extends Equatable {
  final Movie movie;
  final List<DateTime> dates;
  final DateTime selectedDate;
  final List<Session> sessions;

  final bool loading;
  final String? errorMessage;

  const ScheduleState({
    required this.movie,
    required this.selectedDate,
    required this.dates,
    required this.sessions,
    required this.loading,
    this.errorMessage,
  });

  ScheduleState copyWith({
    Movie? movie,
    List<DateTime>? dates,
    DateTime? selectedDate,
    List<Session>? sessions,
    bool? loading,
    String? errorMessage,
  }) {
    return ScheduleState(
      movie: movie ?? this.movie,
      dates: dates ?? this.dates,
      selectedDate: selectedDate ?? this.selectedDate,
      sessions: sessions ?? this.sessions,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        movie,
        dates,
        selectedDate,
        sessions,
        loading,
        errorMessage,
      ];
}
