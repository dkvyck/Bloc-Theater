import 'dart:convert';

import 'package:flutter/cupertino.dart';

class Movie {
  int id;
  String title;
  String overview;
  String? poster_path;
  double popularity;
  DateTime release_date;
  NetworkImage? poster;
  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.poster_path,
    required this.popularity,
    required this.release_date,
    this.poster,
  });

  Movie copyWith({
    int? id,
    String? title,
    String? overview,
    String? poster_path,
    double? popularity,
    DateTime? release_date,
    NetworkImage? poster,
  }) {
    return Movie(
      id: id ?? this.id,
      title: title ?? this.title,
      overview: overview ?? this.overview,
      poster_path: poster_path ?? this.poster_path,
      popularity: popularity ?? this.popularity,
      release_date: release_date ?? this.release_date,
      poster: poster ?? this.poster,
    );
  }

  factory Movie.fromMap(Map<String, dynamic> map) {
    return Movie(
      id: map['id'],
      title: map['title'],
      overview: map['overview'],
      poster_path: map['poster_path'],
      popularity: map['popularity'],
      release_date: DateTime.parse(map['release_date']),
    );
  }

  factory Movie.fromJson(String source) => Movie.fromMap(json.decode(source));

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Movie &&
        other.id == id &&
        other.title == title &&
        other.overview == overview &&
        other.poster_path == poster_path &&
        other.popularity == popularity &&
        other.release_date == release_date &&
        other.poster == poster;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        overview.hashCode ^
        poster_path.hashCode ^
        popularity.hashCode ^
        release_date.hashCode ^
        poster.hashCode;
  }
}
