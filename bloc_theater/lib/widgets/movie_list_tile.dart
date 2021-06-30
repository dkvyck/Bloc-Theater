import 'package:bloc_theater/constants.dart';
import 'package:bloc_theater/models/movie.dart';
import 'package:bloc_theater/screens/movie_details_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MovieListTile extends StatelessWidget {
  final Movie movie;

  const MovieListTile({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var mQuery = MediaQuery.of(context).size;
    return Card(
      color: kListTileColor,
      shadowColor: Colors.transparent,
      elevation: 0,
      child: Container(
        padding: EdgeInsets.all(10),
        child: InkWell(
          onTap: () {
            Navigator.of(context).push(CupertinoPageRoute(
                builder: (ctx) => MovieDetailsScreen(movie: movie)));
          },
          child: Stack(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  height: 150,
                  width: 100,
                  child: movie.poster == null
                      ? Icon(Icons.image, size: mQuery.height * 0.1)
                      : Image(image: movie.poster!),
                ),
                Flexible(
                  flex: 4,
                  child: Container(
                    padding: EdgeInsets.only(left: 5, right: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          movie.title,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: mQuery.height * 0.023),
                        ),
                        Text(
                          movie.overview,
                          maxLines: 3,
                          style: TextStyle(
                              color: Colors.white70,
                              fontSize: mQuery.height * 0.020),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Text(
                              movie.popularity.floor().toString(),
                              style: TextStyle(
                                  fontSize: mQuery.height * 0.03,
                                  color: Colors.white70),
                            ),
                            Icon(
                              Icons.star,
                              color: kStarColor,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Align(
              alignment: Alignment.topRight,
              child: Text(
                DateFormat('dd/MMM/yyyy').format(movie.release_date),
                style: TextStyle(
                    color: Colors.white70, fontSize: mQuery.height * 0.012),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
