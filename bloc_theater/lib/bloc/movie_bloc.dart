import 'package:bloc_theater/models/movie.dart';
import 'package:bloc_theater/repositories/movieRepo.dart';
import 'package:rxdart/rxdart.dart';

class MovieBloc {
  MovieRepo _movieRepo;

  MovieBloc(this._movieRepo);

  final BehaviorSubject<MoviesState> _subject = BehaviorSubject<MoviesState>();

  BehaviorSubject<MoviesState> get subject => _subject;

  getTopRatedMovies({int page = 1}) async {
    _subject.sink.add(MoviesAreLoading());
    try {
      var response = await _movieRepo.getTopRated(pageNumber: page);
      _subject.sink
          .add(MoviesAreLoaded(response, _movieRepo.totalTopRatedPages));
    } catch (e) {
      _subject.sink.add(MoviesAreNotLoaded(exception: e));
    }
  }

  getUpcomingMovies({int page = 1}) async {
    _subject.sink.add(MoviesAreLoading());
    try {
      var response = await _movieRepo.getUpcoming(pageNumber: page);

      _subject.sink
          .add(MoviesAreLoaded(response, _movieRepo.totalUpcomingPages));
    } catch (e) {
      _subject.sink.add(MoviesAreNotLoaded(exception: e));
    }
  }

  dispose() {
    _subject.close();
  }
}

abstract class MoviesState {}

class MoviesAreLoading extends MoviesState {}

class MoviesAreLoaded extends MoviesState {
  final List<Movie> movies;
  final int totalPages;
  MoviesAreLoaded(this.movies, this.totalPages);
}

class MoviesAreNotLoaded extends MoviesState {
  Object exception;
  MoviesAreNotLoaded({
    required this.exception,
  });
}
