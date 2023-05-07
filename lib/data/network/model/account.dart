import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'account.g.dart';

@immutable
@JsonSerializable()
class Account {
  final int id;
  final String? name;
  final String phoneNumber;

  const Account({
    required this.id,
    required this.name,
    required this.phoneNumber,
  });

  factory Account.fromJson(Map<String, dynamic> json) =>
      _$AccountFromJson(json);

  Map<String, dynamic> toJson() => _$AccountToJson(this);
}
