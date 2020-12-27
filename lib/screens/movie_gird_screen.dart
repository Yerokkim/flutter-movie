import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/widgets/layout/Item_cell_widget.dart';

class MovieGridScreen extends StatefulWidget {
  @override
  _MovieGridScreenState createState() => _MovieGridScreenState();
}

Widget grid(AsyncSnapshot<List<Results>> snapshot) {
  return Flexible(
    child: Padding(
      padding: EdgeInsets.all(1.0),
      child: GridView.count(
          childAspectRatio: 0.5,
          crossAxisCount: 2,
          // childAspectRatio: 1.0,
          // mainAxisSpacing: 4.0,
          // crossAxisSpacing: 4.0,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          children: snapshot.data
              .map(
                (e) => GridTile(
                  child: ItemCellWidget(e),
                ),
              )
              .toList()),
    ),
  );
}

class _MovieGridScreenState extends State<MovieGridScreen> {
  final _movieBloc = MovieBloc();
  Future<Movie> _movieModel;

  @override
  void initState() {
    _movieBloc.eventSink.add(MovieAction.Fetch);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Movie App'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            StreamBuilder<List<Results>>(
              stream: _movieBloc.movieStream,
              builder: (context, snapshot) {
                if (snapshot.hasError)
                  return Center(
                    child: Text(snapshot.error ?? 'Error'),
                  );
                if (snapshot.hasData) {
                  return grid(snapshot);
                }

                return Center(child: CircularProgressIndicator());
              },
            ),
          ]),
    );
  }
}
