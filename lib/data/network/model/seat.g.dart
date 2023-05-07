// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Seat _$SeatFromJson(Map<String, dynamic> json) => Seat(
      id: json['id'] as int,
      index: json['index'] as int,
      type: $enumDecode(_$SeatTypeEnumMap, json['type']),
      price: (json['price'] as num).toDouble(),
      isAvailable: json['isAvailable'] as bool,
    );

Map<String, dynamic> _$SeatToJson(Seat instance) => <String, dynamic>{
      'id': instance.id,
      'index': instance.index,
      'type': _$SeatTypeEnumMap[instance.type]!,
      'price': instance.price,
      'isAvailable': instance.isAvailable,
    };

const _$SeatTypeEnumMap = {
  SeatType.vip: 2,
  SeatType.better: 1,
  SeatType.normal: 0,
};
