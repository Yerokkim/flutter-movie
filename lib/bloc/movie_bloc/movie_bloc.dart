import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/movie.dart';

enum MovieAction { Fetch }

class MovieBloc {
  final _stateStreamController = StreamController<List<Results>>();
  StreamSink<List<Results>> get movieSink => _stateStreamController.sink;
  Stream<List<Results>> get movieStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MovieAction>();

  StreamSink<MovieAction> get eventSink => _eventStreamController.sink;
  Stream<MovieAction> get eventStream => _eventStreamController.stream;

  MovieBloc() {
    eventStream.listen((event) async {
      if (event == MovieAction.Fetch) {
        try {
          var movie = await getMovies();

          if (movie != null) movieSink.add(movie.results);
        } catch (e) {}
      }
    });
  }

  Future<Movie> getMovies() async {
    var client = http.Client();
    const apiKey = '235f8d85a7c4198073a406eeb3d67977';
    final String api =
        'https://api.themoviedb.org/3/movie/top_rated?api_key=$apiKey&language=en-US&page=1';
    var movies;

    try {
      var res = await client.get(api);

      if (res.statusCode == 200) {
        var jsonToString = res.body;
        var toJson = json.decode(jsonToString);

        movies = Movie.fromJson(toJson);
      }
    } catch (Exeption) {
      return movies;
    }

    return movies;
  }

  void dipose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
