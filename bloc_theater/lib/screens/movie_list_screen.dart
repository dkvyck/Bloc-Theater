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

  int _currentTabIndex = 0;

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return DefaultTabController(
      child: Scaffold(
        backgroundColor: Color(0xff100E2A),
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
        // body: _tabs[_currentTabIndex],
        // bottomNavigationBar: BottomNavigationBar(
        //   currentIndex: _currentTabIndex,
        //   onTap: (index) {
        //     if (_currentTabIndex != index)
        //       setState(() {
        //         _currentTabIndex = index;
        //       });
        //   },
        //   items: [
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.star_border_outlined), label: 'Top Rated'),
        //     BottomNavigationBarItem(
        //         icon: Icon(Icons.calendar_today_outlined), label: 'Upcoming')
        //   ],
        // ),
      ),
      length: 2,
      initialIndex: 0,
    );
  }
}
