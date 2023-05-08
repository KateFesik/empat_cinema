part of 'session_bloc.dart';

@immutable
class SessionState extends Equatable {
  final int sessionId;
  final Session session;
  final List<Seat> seatsPrice;
  final List<Seat> selectedSeats;
  final double totalPrice;
  final bool loading;
  final String? errorMessage;
  final bool booked;

  const SessionState({
    required this.sessionId,
    required this.session,
    required this.seatsPrice,
    required this.selectedSeats,
    required this.totalPrice,
    required this.loading,
    required this.errorMessage,
    this.booked = false,
  });

  SessionState copyWith({
    int? sessionId,
    Session? session,
    List<Seat>? seatsPrice,
    List<Seat>? selectedSeats,
    double? totalPrice,
    bool? loading,
    String? errorMessage,
    bool? booked,
  }) {
    return SessionState(
      sessionId: sessionId ?? this.sessionId,
      session: session ?? this.session,
      seatsPrice: seatsPrice ?? this.seatsPrice,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      totalPrice: totalPrice ?? this.totalPrice,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      booked: booked ?? this.booked,
    );
  }

  @override
  List<Object?> get props => [
        sessionId,
        session,
        seatsPrice,
        selectedSeats,
        totalPrice,
        loading,
        errorMessage,
        booked,
      ];
}
