import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie.g.dart';

@immutable
@JsonSerializable()
class Movie {
  final int id;
  final String name;
  final int age;
  final String trailer;
  final String image;
  final String smallImage;
  final String originalName;
  final int duration;
  final String language;
  final dynamic rating;
  final int year;
  final String country;
  final String genre;
  final String plot;
  final String starring;
  final String director;
  final String screenwriter;
  final String studio;

  const Movie({
    required this.id,
    required this.name,
    required this.age,
    required this.trailer,
    required this.image,
    required this.smallImage,
    required this.originalName,
    required this.duration,
    required this.language,
    required this.rating,
    required this.year,
    required this.country,
    required this.genre,
    required this.plot,
    required this.starring,
    required this.director,
    required this.screenwriter,
    required this.studio,
  });

  factory Movie.fromJson(Map<String, dynamic> json) =>
      _$MovieFromJson(json);

  Map<String, dynamic> toJson() => _$MovieToJson(this);
}
