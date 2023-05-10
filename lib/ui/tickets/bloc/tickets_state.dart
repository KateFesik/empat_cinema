part of 'tickets_bloc.dart';

@immutable
class TicketsState extends Equatable {
  final Map<String, List<Ticket>> tickets;
  final bool loading;
  final String? errorMessage;

  const TicketsState({
    required this.tickets,
    required this.loading,
    required this.errorMessage,
  });

  TicketsState copyWith({
    Map<String, List<Ticket>>? tickets,
    bool? loading,
    String? errorMessage,
  }) {
    return TicketsState(
      tickets: tickets ?? this.tickets,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  TicketsState copyWithNullError() => TicketsState(
        tickets: tickets,
        loading: loading,
        errorMessage: null,
      );

  @override
  List<Object?> get props => [
        tickets,
        loading,
        errorMessage,
      ];
}
