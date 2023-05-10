part of 'app_bloc.dart';

abstract class AppEvent extends Equatable{}

class AppLoggedIn extends AppEvent {
  @override
  List<Object?> get props => List.empty();
}

class AppLoggedOut extends AppEvent {
  @override
  List<Object?> get props => List.empty();
}