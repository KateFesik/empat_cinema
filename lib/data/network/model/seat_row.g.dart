// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_row.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatRow _$SeatRowFromJson(Map<String, dynamic> json) => SeatRow(
      id: json['id'] as int,
      index: json['index'] as int,
      seats: (json['seats'] as List<dynamic>)
          .map((e) => Seat.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SeatRowToJson(SeatRow instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'seats': instance.seats,
    };
