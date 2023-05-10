part of 'tickets_bloc.dart';

@immutable
abstract class TicketsEvent extends Equatable {}

class TicketsStarted extends TicketsEvent {
  @override
  List<Object?> get props => List.empty();
}

class TicketsErrorShown extends TicketsEvent {
  @override
  List<Object?> get props => List.empty();
}
