import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_bloc/reco_bloc.dart';
import 'package:movie_app/model/movie.dart';

import 'package:movie_app/widgets/layout/reco_cell_widget.dart';

class MovieRecoScreen extends StatefulWidget {
  const MovieRecoScreen(this.id);

  @required
  final num id;

  @override
  _MovieRecoScreenState createState() => _MovieRecoScreenState();
}

class _MovieRecoScreenState extends State<MovieRecoScreen> {
  num _id;

  var _recoBloc;
  @override
  void initState() {
    _id = widget.id;
    _recoBloc = RecoBloc(_id);

    _recoBloc.eventSink.add(MovieRecoAction.Fetch);
    super.initState();
  }

  Widget recoLayout(AsyncSnapshot<List<Results>> snapshot) {
    return Flexible(
      child: Container(
        height: 320,
        // width: 230,
        // padding: EdgeInsets.all(1.0),
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: snapshot.data
              .map(
                (e) => Card(
                  child: RecoCellWidget(e),
                ),
              )
              .toList(),
        ),
      ),
    );
  }

  // MovieVideoScreen(widget.id)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Recommendation',
              style: TextStyle(fontSize: 30, color: Colors.white),
            ),
          ),
          StreamBuilder<List<Results>>(
            stream: _recoBloc.recoStream,
            builder: (context, snapshot) {
              if (snapshot.hasError)
                return Center(
                  child: Text(snapshot.error ?? 'Error'),
                );
              if (snapshot.hasData) {
                return recoLayout(snapshot);
              }

              return Center(child: CircularProgressIndicator());
            },
          ),
        ],
      ),
    );
  }
}
