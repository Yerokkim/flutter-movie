import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movie_app/model/movieActors.dart';

enum MovieActorAction { Fetch }

class ActorBloc {
  final _stateStreamController = StreamController<List<Cast>>();
  StreamSink<List<Cast>> get actorSink => _stateStreamController.sink;
  Stream<List<Cast>> get actorStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MovieActorAction>();

  StreamSink<MovieActorAction> get eventSink => _eventStreamController.sink;
  Stream<MovieActorAction> get eventStream => _eventStreamController.stream;

  ActorBloc(movieId) {
    eventStream.listen((event) async {
      if (event == MovieActorAction.Fetch) {
        try {
          var actor = await getActors(movieId);

          if (actor != null) actorSink.add(actor.cast);
        } catch (e) {}
      }
    });
  }

  Future<Actors> getActors(movieId) async {
    var client = http.Client();
    const apiKey = '235f8d85a7c4198073a406eeb3d67977';
    final String api =
        'https://api.themoviedb.org/3/movie/$movieId/credits?api_key=$apiKey&language=en-US';
    var actors;

    try {
      var res = await client.get(api);

      if (res.statusCode == 200) {
        var jsonToString = res.body;
        var toJson = json.decode(jsonToString);

        actors = Actors.fromJson(toJson);
      }
    } catch (Exeption) {
      return actors;
    }

    return actors;
  }

  void dipose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
