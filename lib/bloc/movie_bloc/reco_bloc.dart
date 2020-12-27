import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
// import 'package:movie_app/model/movieRecommendation.dart';
import 'package:movie_app/model/movie.dart';

enum MovieRecoAction { Fetch }

class RecoBloc {
  final _stateStreamController = StreamController<List<Results>>();
  StreamSink<List<Results>> get recoSink => _stateStreamController.sink;
  Stream<List<Results>> get recoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MovieRecoAction>();

  StreamSink<MovieRecoAction> get eventSink => _eventStreamController.sink;
  Stream<MovieRecoAction> get eventStream => _eventStreamController.stream;

  RecoBloc(movieId) {
    eventStream.listen((event) async {
      if (event == MovieRecoAction.Fetch) {
        try {
          var recos = await getReco(movieId);

          if (recos != null) recoSink.add(recos.results);
        } catch (e) {}
      }
    });
  }

  Future<Movie> getReco(movieId) async {
    var client = http.Client();
    const apiKey = '235f8d85a7c4198073a406eeb3d67977';
    final String api =
        'https://api.themoviedb.org/3/movie/$movieId/recommendations?api_key=$apiKey&language=en-US';
    var recos;

    try {
      var res = await client.get(api);

      if (res.statusCode == 200) {
        var jsonToString = res.body;
        var toJson = json.decode(jsonToString);

        recos = Movie.fromJson(toJson);
      }
    } catch (Exeption) {
      return recos;
    }

    return recos;
  }

  void dipose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
