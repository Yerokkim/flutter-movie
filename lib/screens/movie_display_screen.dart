import 'package:flutter/material.dart';
import 'package:movie_app/bloc/movie_bloc/movie_bloc.dart';
import 'package:movie_app/model/movie.dart';

class MovieDisplayScreen extends StatefulWidget {
  @override
  _MovieDisplayScreenState createState() => _MovieDisplayScreenState();
}

class _MovieDisplayScreenState extends State<MovieDisplayScreen> {
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
        title: Text('News App'),
      ),
      body: Container(
        child: StreamBuilder<List<Results>>(
          stream: _movieBloc.movieStream,
          builder: (context, snapshot) {
            if (snapshot.hasError)
              return Center(
                child: Text(snapshot.error ?? 'Error'),
              );
            if (snapshot.hasData) {
              return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, index) {
                    var movies = snapshot.data[index];

                    return Container(
                      height: 200,
                      margin: const EdgeInsets.all(8),
                      child: Row(
                        children: <Widget>[
                          Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: AspectRatio(
                                aspectRatio: 4,
                                child: Image.network(
                                  "https://image.tmdb.org/t/p/original/" +
                                      movies.backdropPath,
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: 16),
                        ],
                      ),
                    );
                  });
            } else
              return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
