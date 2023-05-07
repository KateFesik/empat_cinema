import 'package:cinema/data/network/model/seat_row.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'room.g.dart';

@immutable
@JsonSerializable()
class Room {
  final int id;
  final String name;
  final List<SeatRow> rows;

  const Room({
    required this.id,
    required this.name,
    required this.rows,
  });

  factory Room.fromJson(Map<String, dynamic> json) =>
      _$RoomFromJson(json);

  Map<String, dynamic> toJson() => _$RoomToJson(this);
}