part of 'app_bloc.dart';

enum AuthenticationState {
  initial,
  authenticated,
  loginRequired,
}

@immutable
class AppState  extends Equatable{
  final AuthenticationState authenticationState;

  const AppState(this.authenticationState);

  @override
  List<Object?> get props => [authenticationState];
}
