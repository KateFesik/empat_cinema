part of 'account_bloc.dart';

@immutable
abstract class AccountEvent extends Equatable {}

class AccountStarted extends AccountEvent {
  @override
  List<Object?> get props => List.empty();
}

class AccountNameSaved extends AccountEvent {
  final String name;

  AccountNameSaved({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}
