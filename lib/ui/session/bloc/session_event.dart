part of 'session_bloc.dart';

@immutable
abstract class SessionEvent extends Equatable {}

class InitSession extends SessionEvent {
  final List<SeatRow> rows;

  InitSession({
    required this.rows,
  });

  @override
  List<Object?> get props => [
        rows,
      ];
}

class OnSeatSelected extends SessionEvent {
  final Seat seat;

  OnSeatSelected({
    required this.seat,
  });

  @override
  List<Object?> get props => [
        seat,
      ];
}

class OnBookTickets extends SessionEvent {
  @override
  List<Object?> get props => List.empty();
}

class OnErrorShown extends SessionEvent {
  @override
  List<Object?> get props => List.empty();
}

class OnNavigationHandledEvent extends SessionEvent {
  @override
  List<Object?> get props => List.empty();
}
