part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable {}

class LoginAnonymousPressed extends LoginEvent {
  @override
  List<Object?> get props => List.empty();
}

class LoginPhoneSubmitted extends LoginEvent {
  final String phone;

  LoginPhoneSubmitted({
    required this.phone,
  });

  @override
  List<Object?> get props => [phone];
}

class LoginOtpSubmitted extends LoginEvent {
  final String otp;

  LoginOtpSubmitted({
    required this.otp,
  });

  @override
  List<Object?> get props => [otp];
}

class LoginErrorShown extends LoginEvent {
  @override
  List<Object?> get props => List.empty();
}
