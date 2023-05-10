// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      id: json['id'] as int,
      movieId: json['movieId'] as int,
      name: json['name'] as String,
      date: const DateTimeConverter().fromJson(json['date'] as int),
      image: json['image'] as String,
      smallImage: json['smallImage'] as String,
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'id': instance.id,
      'movieId': instance.movieId,
      'name': instance.name,
      'date': const DateTimeConverter().toJson(instance.date),
      'image': instance.image,
      'smallImage': instance.smallImage,
    };
