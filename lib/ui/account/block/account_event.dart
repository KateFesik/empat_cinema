part of 'account_bloc.dart';

@immutable
abstract class AccountEvent extends Equatable {}

class InitAccount extends AccountEvent {
  @override
  List<Object?> get props => List.empty();
}

class SaveName extends AccountEvent {
  final String name;

  SaveName({
    required this.name,
  });

  @override
  List<Object?> get props => [name];
}
