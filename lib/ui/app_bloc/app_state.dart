part of 'app_bloc.dart';

enum AuthenticationState {
  started,
  authenticated,
  loginRequired,
}

enum AuthenticationType {
  anonymousLogin,
  otpLogin;
}

@immutable
class AppState extends Equatable {
  final AuthenticationState authenticationState;
  final AuthenticationType? authenticationType;

  const AppState({
    required this.authenticationState,
    required this.authenticationType,
  });

  AppState copyWith({
    AuthenticationState? authenticationState,
    AuthenticationType? authenticationType,
  }) {
    return AppState(
      authenticationState: authenticationState ?? this.authenticationState,
      authenticationType: authenticationType ?? this.authenticationType,
    );
  }

  @override
  List<Object?> get props => [
        authenticationState,
        authenticationType,
      ];
}
