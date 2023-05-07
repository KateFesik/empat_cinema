part of 'app_bloc.dart';

abstract class AppEvent extends Equatable{}

class OnLoggedIn extends AppEvent {
  @override
  List<Object?> get props => List.empty();
}

class OnLoggedOut extends AppEvent {
  @override
  List<Object?> get props => List.empty();
}