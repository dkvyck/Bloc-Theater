import 'package:bloc_theater/constants.dart';
import 'package:bloc_theater/screens/top_rated_movie_list.dart';
import 'package:bloc_theater/screens/upcoming_movie_list.dart';
import 'package:flutter/material.dart';

class MovieListScreen extends StatefulWidget {
  @override
  _MovieListScreenState createState() => _MovieListScreenState();
}

class _MovieListScreenState extends State<MovieListScreen> {
  List<Widget> _tabs = [
    TopRatedMovieList(),
    UpcomingMovieList(),
  ];

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return DefaultTabController(
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          title: TabBar(
            isScrollable: true,
            indicator: BoxDecoration(),
            labelStyle: TextStyle(fontSize: mQuery.height * 0.03),
            unselectedLabelStyle: TextStyle(fontSize: mQuery.height * 0.025),
            tabs: [
              Tab(
                text: 'Top Rated',
              ),
              Tab(
                text: 'Upcoming',
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: _tabs,
        ),
      ),
      length: 2,
      initialIndex: 0,
    );
  }
}
