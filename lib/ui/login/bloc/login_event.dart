part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class AnonymousLogin extends LoginEvent {
  @override
  List<Object?> get props => List.empty();
}

class SubmitPhone extends LoginEvent {
  final String phone;

  SubmitPhone({
    required this.phone,
  });

  @override
  List<Object?> get props => [phone];
}

class SubmitOtp extends LoginEvent {
  final String otp;

  SubmitOtp({
    required this.otp,
  });

  @override
  List<Object?> get props => [otp];
}

class OnErrorShown extends LoginEvent {
  @override
  List<Object?> get props => List.empty();
}
