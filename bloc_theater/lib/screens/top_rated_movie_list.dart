import 'package:bloc_theater/bloc/movie_bloc.dart';
import 'package:bloc_theater/models/movie.dart';
import 'package:bloc_theater/repositories/movieRepo.dart';
import 'package:bloc_theater/widgets/movie_list_tile.dart';
import 'package:flutter/material.dart';

class TopRatedMovieList extends StatefulWidget {
  @override
  _TopRatedMoviesState createState() => _TopRatedMoviesState();
}

class _TopRatedMoviesState extends State<TopRatedMovieList> {
  late MovieBloc bloc;
  late MovieRepo repo;

  @override
  void initState() {
    super.initState();
    repo = MovieRepo();
    bloc = MovieBloc(repo);
    bloc.getTopRatedMovies();
  }

  List<Movie> _items = [];
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
      child: StreamBuilder(
        stream: bloc.subject.stream,
        builder: (ctx, snap) {
          if (snap.data is MoviesAreLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snap.data is MoviesAreNotLoaded) {
            return Center(
              child: ErrorWidget((snap.data as MoviesAreNotLoaded).exception),
            );
          } else if (snap.data is MoviesAreLoaded) {
            _items.addAll((snap.data as MoviesAreLoaded).movies);
            return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      _currentPage != repo.totalTopRatedPages) {
                    bloc.getTopRatedMovies(page: _currentPage + 1);
                    _currentPage++;
                  }
                  return true;
                },
                child: ListView.builder(
                  key: const PageStorageKey<String>('TopRatedList'),
                  padding: EdgeInsets.all(10),
                  itemExtent: 180,
                  itemBuilder: (ctx1, index) {
                    return MovieListTile(movie: _items[index]);
                  },
                  itemCount: _items.length,
                ));
          } else
            return Center(
              child: CircularProgressIndicator(
                color: Colors.white70,
              ),
            );
        },
      ),
    );
  }
}
