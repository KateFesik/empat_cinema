part of 'payment_bloc.dart';

@immutable
class PaymentState extends Equatable {
  final int sessionId;
  final List<int> seatIds;
  final double totalPrice;
  final bool loading;
  final String? errorMessage;
  final bool ordered;

  const PaymentState({
    required this.sessionId,
    required this.seatIds,
    required this.totalPrice,
    required this.loading,
    required this.errorMessage,
    this.ordered = false,
  });

  PaymentState copyWith({
    int? sessionId,
    List<int>? seatIds,
    double? totalPrice,
    bool? loading,
    String? errorMessage,
    bool? ordered,
  }) {
    return PaymentState(
      sessionId: sessionId ?? this.sessionId,
      seatIds: seatIds ?? this.seatIds,
      totalPrice: totalPrice ?? this.totalPrice,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      ordered: ordered ?? this.ordered,
    );
  }

  PaymentState copyWithNullError() => PaymentState(
        sessionId: sessionId,
        seatIds: seatIds,
        totalPrice: totalPrice,
        loading: loading,
        errorMessage: null,
        ordered: ordered,
      );

  @override
  List<Object?> get props => [
        sessionId,
        seatIds,
        totalPrice,
        loading,
        errorMessage,
        ordered,
      ];
}
