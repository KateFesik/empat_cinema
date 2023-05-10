part of 'session_bloc.dart';

@immutable
abstract class SessionEvent extends Equatable {}

class SessionStarted extends SessionEvent {

  @override
  List<Object?> get props => List.empty();
}

class SessionSeatSelected extends SessionEvent {
  final Seat seat;

  SessionSeatSelected({
    required this.seat,
  });

  @override
  List<Object?> get props => [
        seat,
      ];
}

class SessionTicketsBooked extends SessionEvent {
  @override
  List<Object?> get props => List.empty();
}

class SessionErrorShown extends SessionEvent {
  @override
  List<Object?> get props => List.empty();
}

class SessionNavigationHandled extends SessionEvent {
  @override
  List<Object?> get props => List.empty();
}
