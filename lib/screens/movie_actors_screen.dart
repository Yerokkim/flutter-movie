import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_bloc/actor_bloc.dart';
import 'package:movie_app/model/movieActors.dart';

import 'package:movie_app/widgets/layout/actor_cell_widget.dart';
import 'package:movie_app/screens/movie_video_screen.dart';

class MovieActorsScreen extends StatefulWidget {
  const MovieActorsScreen(this.id);

  @required
  final num id;

  @override
  _MovieActorsScreenState createState() => _MovieActorsScreenState();
}

class _MovieActorsScreenState extends State<MovieActorsScreen> {
  num _id;

  var _actorBloc;
  @override
  void initState() {
    _id = widget.id;
    _actorBloc = ActorBloc(_id);

    _actorBloc.eventSink.add(MovieActorAction.Fetch);
    super.initState();
  }

  Widget actorLayout(AsyncSnapshot<List<Cast>> snapshot) {
    return Container(
      // padding: EdgeInsets.all(1.0),
      child: GridView.count(
        crossAxisCount: 4,
        childAspectRatio: 0.7,
        primary: false,
        crossAxisSpacing: 0,
        mainAxisSpacing: 0,
        shrinkWrap: true,
        children: snapshot.data.length >= 8
            ? snapshot.data
                .sublist(0, 8)
                .map(
                  (e) => GridTile(
                    child: ActorCellWidget(e),
                  ),
                )
                .toList()
            : snapshot.data
                .map(
                  (e) => GridTile(
                    child: ActorCellWidget(e),
                  ),
                )
                .toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Cast>>(
          stream: _actorBloc.actorStream,
          builder: (context, snapshot) {
            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    height: 200,
                    child: MovieVideoScreen(widget.id),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Cast',
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                  ),
                  if (snapshot.hasError)
                    Center(
                      child: Text(snapshot.error ?? 'Error'),
                    ),
                  if (snapshot.hasData) actorLayout(snapshot),
                  //  Center(child: CircularProgressIndicator())
                ],
              ),
            );
          }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:movie_app/bloc/movie_bloc/actor_bloc.dart';
// import 'package:movie_app/model/movieActors.dart';

// import 'package:movie_app/widgets/layout/actor_cell_widget.dart';
// import 'package:movie_app/screens/movie_video_screen.dart';

// class MovieActorsScreen extends StatefulWidget {
//   const MovieActorsScreen(this.id);

//   @required
//   final num id;

//   @override
//   _MovieActorsScreenState createState() => _MovieActorsScreenState();
// }

// class _MovieActorsScreenState extends State<MovieActorsScreen> {
//   num _id;

//   var _actorBloc;
//   @override
//   void initState() {
//     _id = widget.id;
//     _actorBloc = ActorBloc(_id);

//     _actorBloc.eventSink.add(MovieActorAction.Fetch);
//     super.initState();
//   }

//   Widget actorLayout(AsyncSnapshot<List<Cast>> snapshot) {
//     return Flexible(
//       child: Container(
//         // padding: EdgeInsets.all(1.0),
//         child: GridView.count(
//           crossAxisCount: 4,
//           childAspectRatio: 0.7,
//           primary: false,
//           crossAxisSpacing: 0,
//           mainAxisSpacing: 0,
//           children: snapshot.data.length >= 8
//               ? snapshot.data
//                   .sublist(0, 8)
//                   .map(
//                     (e) => GridTile(
//                       child: ActorCellWidget(e),
//                     ),
//                   )
//                   .toList()
//               : snapshot.data
//                   .map(
//                     (e) => GridTile(
//                       child: ActorCellWidget(e),
//                     ),
//                   )
//                   .toList(),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: <Widget>[
//           Container(
//             height: 200,
//             child: MovieVideoScreen(240),
//           ),
//           SizedBox(
//             height: 30,
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(
//               'Cast',
//               style: TextStyle(fontSize: 30, color: Colors.white),
//             ),
//           ),
//           StreamBuilder<List<Cast>>(
//             stream: _actorBloc.actorStream,
//             builder: (context, snapshot) {
//               if (snapshot.hasError)
//                 return Center(
//                   child: Text(snapshot.error ?? 'Error'),
//                 );
//               if (snapshot.hasData) {
//                 return actorLayout(snapshot);
//               }

//               return Center(child: CircularProgressIndicator());
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }
