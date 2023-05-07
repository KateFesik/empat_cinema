import 'package:cinema/data/network/model/seat.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_row.g.dart';

@immutable
@JsonSerializable()
class SeatRow {
  final int id;
  final int index;
  final List<Seat> seats;

  const SeatRow({
    required this.id,
    required this.index,
    required this.seats,
  });

  factory SeatRow.fromJson(Map<String, dynamic> json) =>
      _$SeatRowFromJson(json);

  Map<String, dynamic> toJson() => _$SeatRowToJson(this);
}
