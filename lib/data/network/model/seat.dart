import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat.g.dart';

@JsonEnum()
enum SeatType {
  @JsonValue(2)
  vip("Vip"),
  @JsonValue(1)
  better("Better"),
  @JsonValue(0)
  normal("Normal");

  final String displayableName;

  const SeatType(this.displayableName);
}

@immutable
@JsonSerializable()
class Seat extends Equatable {
  final int id;
  final int index;
  final SeatType type;
  final double price;
  final bool isAvailable;

  const Seat({
    required this.id,
    required this.index,
    required this.type,
    required this.price,
    required this.isAvailable,
  });

  factory Seat.fromJson(Map<String, dynamic> json) => _$SeatFromJson(json);

  Map<String, dynamic> toJson() => _$SeatToJson(this);

  @override
  List<Object> get props => [id, index, type, price, isAvailable];
}
