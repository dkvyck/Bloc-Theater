import 'dart:convert';

import 'package:bloc_theater/constants.dart';
import 'package:bloc_theater/models/movie.dart';
import 'package:bloc_theater/repositories/movieRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;

void main() {
  test('Get TopRated', () async {
    var repo = MovieRepo();
    var movies = await repo.getTopRated();

    movies.forEach((movie) {
      print(movie.title);
    });

    expect(movies.length, isNot(equals(0)));
  });
}
