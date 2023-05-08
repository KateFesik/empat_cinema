part of 'payment_bloc.dart';

@immutable
abstract class PaymentEvent extends Equatable {}

class InitPayment extends PaymentEvent {
  @override
  List<Object?> get props => List.empty();
}

class OnErrorShown extends PaymentEvent {
  @override
  List<Object?> get props => List.empty();
}

class OnOrder extends PaymentEvent {
  final String email;
  final String cardNumber;
  final String expirationDate;
  final String cvv;

  OnOrder({
    required this.email,
    required this.cardNumber,
    required this.expirationDate,
    required this.cvv,
  });

  @override
  List<Object?> get props => [
        email,
        cardNumber,
        expirationDate,
        cvv,
      ];
}
