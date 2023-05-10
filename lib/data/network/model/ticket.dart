import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'converters.dart';

part 'ticket.g.dart';

@immutable
@JsonSerializable()
class Ticket{
  final int id;
  final int movieId;
  final String name;
  @DateTimeConverter()
  final DateTime date;
  final String image;
  final String smallImage;

  const Ticket({
    required this.id,
    required this.movieId,
    required this.name,
    required this.date,
    required this.image,
    required this.smallImage,
  });


  factory Ticket.fromJson(Map<String, dynamic> json) =>
      _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);
}