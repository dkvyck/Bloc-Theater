import 'package:bloc_theater/models/movie.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';

class MovieDetailsScreen extends StatelessWidget {
  final Movie movie;

  const MovieDetailsScreen({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Color(0xff100E2A),
      body: Container(
        padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    color: Colors.black.withOpacity(0.5),
                    height: mQuery.height * 0.4,
                    width: double.infinity,
                    child: movie.poster != null
                        ? Image(
                            image: movie.poster!,
                          )
                        : Icon(Icons.image),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.bottomLeft,
                    height: mQuery.height * 0.38,
                    child: Text(
                      DateFormat('MM/dd/yyyy').format(movie.release_date),
                      style: TextStyle(
                          color: Colors.white70,
                          fontSize: mQuery.height * 0.02),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10),
                    height: mQuery.height * 0.38,
                    alignment: Alignment.bottomCenter,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          movie.popularity.floor().toString(),
                          style: TextStyle(
                              fontSize: mQuery.height * 0.03,
                              color: Colors.white70),
                        ),
                        Icon(
                          Icons.star,
                          color: Color(0xffDFC44B),
                        ),
                      ],
                    ),
                  ),
                  _buildAppBar(context),
                ],
              ),
              Card(
                margin: EdgeInsets.all(10),
                color: Color(0xff171638),
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        movie.title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: mQuery.height * 0.03,
                            color: Colors.white70),
                      ),
                      Container(
                        padding: EdgeInsets.all(8),
                        child: ReadMoreText(
                          movie.overview,
                          trimMode: TrimMode.Line,
                          trimLines: 5,
                          style: TextStyle(
                              fontSize: mQuery.height * 0.020,
                              color: Colors.white70),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _buildAppBar(BuildContext context) {
    return Row(
      children: [
        IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            splashRadius: 1,
            icon: Icon(
              Icons.arrow_back_ios_new,
              color: Colors.white,
            )),
      ],
    );
  }
}
