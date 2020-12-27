import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_app/model/movieVideo.dart';

enum MovieVideoAction { Fetch }

class VideoBloc {
  final _stateStreamController = StreamController<List<Results>>();
  StreamSink<List<Results>> get videoSink => _stateStreamController.sink;
  Stream<List<Results>> get videoStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<MovieVideoAction>();

  StreamSink<MovieVideoAction> get eventSink => _eventStreamController.sink;
  Stream<MovieVideoAction> get eventStream => _eventStreamController.stream;

  VideoBloc(movieId) {
    eventStream.listen((event) async {
      if (event == MovieVideoAction.Fetch) {
        try {
          var video = await getVideo(movieId);

          if (video != null) videoSink.add(video.results);
        } catch (e) {}
      }
    });
  }

  Future<Video> getVideo(movieId) async {
    var client = http.Client();
    const apiKey = '235f8d85a7c4198073a406eeb3d67977';
    final String api =
        'https://api.themoviedb.org/3/movie/$movieId/videos?api_key=$apiKey&language=en-US';
    var video;

    try {
      var res = await client.get(api);

      if (res.statusCode == 200) {
        var jsonToString = res.body;
        var toJson = json.decode(jsonToString);

        video = Video.fromJson(toJson);
      }
    } catch (Exeption) {
      return video;
    }

    return video;
  }

  void dipose() {
    _stateStreamController.close();
    _eventStreamController.close();
  }
}
