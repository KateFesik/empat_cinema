part of 'login_bloc.dart';

@immutable
class LoginState extends Equatable {
  final String? phone;
  final bool loading;
  final String? errorMessage;
  final bool isOtpSent;

  const LoginState({
    required this.phone,
    required this.loading,
    required this.errorMessage,
    required this.isOtpSent,
  });

  LoginState copyWith({
    String? phone,
    bool? loading,
    String? errorMessage,
    bool? isOtpSent,
  }) {
    return LoginState(
      phone: phone ?? this.phone,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
      isOtpSent: isOtpSent ?? this.isOtpSent,
    );
  }

  @override
  List<Object?> get props => [
        phone,
        loading,
        errorMessage,
        isOtpSent,
      ];
}
