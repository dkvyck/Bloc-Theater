import 'package:bloc_theater/bloc/movie_bloc.dart';
import 'package:bloc_theater/models/movie.dart';
import 'package:bloc_theater/repositories/movieRepo.dart';
import 'package:bloc_theater/widgets/movie_list_tile.dart';
import 'package:flutter/material.dart';

class UpcomingMovieList extends StatefulWidget {
  @override
  _UpcomingMoviesState createState() => _UpcomingMoviesState();
}

class _UpcomingMoviesState extends State<UpcomingMovieList> {
  late MovieBloc bloc;

  @override
  void initState() {
    super.initState();
    bloc = MovieBloc(MovieRepo());
    bloc.getUpcomingMovies();
  }

  List<Movie> _items = [];
  int _currentPage = 1;

  @override
  Widget build(BuildContext context) {
    print(_items.length);
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
              child:
                  Text((snap.data as MoviesAreNotLoaded).exception.toString()),
            );
          } else if (snap.data is MoviesAreLoaded) {
            var state = (snap.data as MoviesAreLoaded);
            _items.addAll(state.movies);
            return NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.pixels ==
                          scrollInfo.metrics.maxScrollExtent &&
                      _currentPage != state.totalPages) {
                    bloc.getUpcomingMovies(page: _currentPage + 1);
                    _currentPage++;
                  }
                  return true;
                },
                child: ListView.builder(
                  key: const PageStorageKey<String>('UpcomingList'),
                  padding: EdgeInsets.all(10),
                  itemExtent: 180,
                  itemBuilder: (ctx1, index) {
                    return MovieListTile(movie: _items[index]);
                  },
                  itemCount: _items.length,
                ));
          } else
            return Center(
              child: CircularProgressIndicator(),
            );
        },
      ),
    );
  }
}
