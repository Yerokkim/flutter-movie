import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';

import 'package:movie_app/screens/movie_actors_screen.dart';
import 'package:movie_app/screens/movie_recommendations_screen.dart';
import 'package:movie_app/screens/movie_video_screen.dart';
import 'package:movie_app/widgets/title_desc_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  const MovieDetailScreen(this.item);

  @required
  final Results item;

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 700,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          colorFilter: ColorFilter.mode(
                              Colors.black.withOpacity(0.2), BlendMode.dstATop),
                          image: NetworkImage(
                            "https://image.tmdb.org/t/p/original/" +
                                widget.item.backdropPath,
                          ),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(30.0),
                    child: Stack(
                      children: <Widget>[
                        TitleDescriptionWidget(
                            widget.item.title, widget.item.overview)
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverFillRemaining(
            child: PageView(
              pageSnapping: false,
              controller: PageController(initialPage: 0),
              scrollDirection: Axis.vertical,
              children: [
                MovieActorsScreen(widget.item.id),
                // MovieVideoScreen(widget.item.id),
                MovieRecoScreen(widget.item.id)
              ],
            ),
            // child:
          ),
        ],
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:movie_app/model/movie.dart';
// import 'package:movie_app/screens/movie_actors_screen.dart';
// import 'package:movie_app/widgets/title_desc_widget.dart';

// class MovieDetailScreen extends StatefulWidget {
//   const MovieDetailScreen(this.item);

//   @required
//   final Results item;

//   @override
//   _MovieDetailScreenState createState() => _MovieDetailScreenState();
// }

// class _MovieDetailScreenState extends State<MovieDetailScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//       pageSnapping: false,
//       controller: PageController(initialPage: 0),
//       scrollDirection: Axis.vertical,
//       children: <Widget>[
//         Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(
//                 image: NetworkImage(
//                   "https://image.tmdb.org/t/p/original/" +
//                       widget.item.backdropPath,
//                 ),
//                 fit: BoxFit.cover),
//           ),
//           child: Container(
//             decoration: BoxDecoration(
//               gradient: LinearGradient(
//                 colors: [
//                   Colors.black.withOpacity(.3),
//                   Colors.black.withOpacity(.3),
//                 ],
//               ),
//             ),
//             child: Padding(
//               padding: EdgeInsets.all(10.0),
//               child: Stack(
//                 children: <Widget>[
//                   Positioned(
//                     top: 16,
//                     left: 0,
//                     child: GestureDetector(
//                       onTap: () {
//                         Navigator.pop(context);
//                       },
//                       child: Icon(Icons.arrow_back),
//                     ),
//                   ),
//                   TitleDescriptionWidget(
//                       widget.item.title, widget.item.overview)
//                 ],
//               ),
//             ),
//           ),
//         ),
//         //여기서부터 다른 페이지
//         MovieActorsScreen(widget.item.id)
//       ],
//     ));
//   }
// }
