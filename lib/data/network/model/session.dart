import 'package:cinema/data/network/model/converters.dart';
import 'package:cinema/data/network/model/room.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session.g.dart';

@immutable
@JsonSerializable()
class Session {
  final int id;
  @DateTimeConverter()
  final DateTime date;
  final String type;
  final int minPrice;
  final Room room;

  const Session({
    required this.id,
    required this.date,
    required this.type,
    required this.minPrice,
    required this.room,
  });

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);
}