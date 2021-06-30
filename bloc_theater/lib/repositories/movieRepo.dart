import 'dart:convert';

import 'package:bloc_theater/constants.dart';
import 'package:bloc_theater/models/movie.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class MovieRepo {
  var host = 'api.themoviedb.org';
  var img_host = 'image.tmdb.org';

  int totalTopRatedPages = 0;
  int totalUpcomingPages = 0;

  Future<List<Movie>> getTopRated({int pageNumber = 1}) async {
    var uri = Uri.https(host, '/3/movie/top_rated', {
      'api_key': kAPIKey,
      'language': 'en-US',
      'page': pageNumber.toString(),
    });

    var response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception();
    }

    var movies = json.decode(response.body) as Map<String, dynamic>;
    var movieList = movies['results'].map<Future<Movie>>((el) async {
      var movie = Movie.fromMap(el);
      if (movie.poster_path != null) {
        var imgUrl = Uri.https(
          img_host,
          '/t/p/w500/${movie.poster_path}',
        );
        var poster = NetworkImage(imgUrl.toString());
        movie.poster = poster;
      }
      return movie;
    });

    totalTopRatedPages = movies['total_pages'];
    return Future.wait(movieList);
  }

  Future<List<Movie>> getUpcoming({int pageNumber = 1}) async {
    var uri = Uri.https(host, '/3/movie/upcoming', {
      'api_key': kAPIKey,
      'language': 'en-US',
      'page': pageNumber.toString(),
    });

    var response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception();
    }
    var movies = json.decode(response.body) as Map<String, dynamic>;
    var movieList = movies['results'].map<Future<Movie>>((el) async {
      var movie = Movie.fromMap(el);
      if (movie.poster_path != null) {
        var imgUrl = Uri.https(
          img_host,
          '/t/p/w500/${movie.poster_path}',
        );
        var poster = NetworkImage(imgUrl.toString());
        movie.poster = poster;
      }
      return movie;
    });

    totalUpcomingPages = movies['total_pages'];
    return Future.wait(movieList);
  }
}
