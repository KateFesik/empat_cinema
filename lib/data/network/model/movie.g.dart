// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Movie _$MovieFromJson(Map<String, dynamic> json) => Movie(
      id: json['id'] as int,
      name: json['name'] as String,
      age: json['age'] as int,
      trailer: json['trailer'] as String,
      image: json['image'] as String,
      smallImage: json['smallImage'] as String,
      originalName: json['originalName'] as String,
      duration: json['duration'] as int,
      language: json['language'] as String,
      rating: json['rating'],
      year: json['year'] as int,
      country: json['country'] as String,
      genre: json['genre'] as String,
      plot: json['plot'] as String,
      starring: json['starring'] as String,
      director: json['director'] as String,
      screenwriter: json['screenwriter'] as String,
      studio: json['studio'] as String,
    );

Map<String, dynamic> _$MovieToJson(Movie instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'age': instance.age,
      'trailer': instance.trailer,
      'image': instance.image,
      'smallImage': instance.smallImage,
      'originalName': instance.originalName,
      'duration': instance.duration,
      'language': instance.language,
      'rating': instance.rating,
      'year': instance.year,
      'country': instance.country,
      'genre': instance.genre,
      'plot': instance.plot,
      'starring': instance.starring,
      'director': instance.director,
      'screenwriter': instance.screenwriter,
      'studio': instance.studio,
    };
