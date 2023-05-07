part of 'account_bloc.dart';

@immutable
class AccountState extends Equatable {
  final String? phone;
  final String? name;
  final bool loading;
  final String? errorMessage;

  const AccountState({
    required this.phone,
    required this.name,
    required this.loading,
    required this.errorMessage,
  });

  AccountState copyWith({
    String? phone,
    String? name,
    bool? loading,
    String? errorMessage,
  }) {
    return AccountState(
      phone: phone ?? this.phone,
      name: name ?? this.name,
      loading: loading ?? this.loading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [
        phone,
        name,
        loading,
        errorMessage,
      ];
}
