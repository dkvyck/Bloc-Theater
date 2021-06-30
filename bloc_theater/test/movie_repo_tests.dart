import 'package:bloc_theater/repositories/movieRepo.dart';
import 'package:flutter_test/flutter_test.dart';

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
