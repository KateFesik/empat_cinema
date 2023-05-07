// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'session.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Session _$SessionFromJson(Map<String, dynamic> json) => Session(
      id: json['id'] as int,
      date: const DateTimeConverter().fromJson(json['date'] as int),
      type: json['type'] as String,
      minPrice: json['minPrice'] as int,
      room: Room.fromJson(json['room'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$SessionToJson(Session instance) => <String, dynamic>{
      'id': instance.id,
      'date': const DateTimeConverter().toJson(instance.date),
      'type': instance.type,
      'minPrice': instance.minPrice,
      'room': instance.room,
    };
