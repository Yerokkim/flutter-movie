import 'package:flutter/material.dart';

import 'package:movie_app/bloc/movie_bloc/video_bloc.dart';
import 'package:movie_app/model/movieVideo.dart';
import 'package:movie_app/widgets/youtube_video_widget.dart';

class MovieVideoScreen extends StatefulWidget {
  const MovieVideoScreen(this.id);

  @required
  final num id;

  @override
  _MovieVideoScreenState createState() => _MovieVideoScreenState();
}

class _MovieVideoScreenState extends State<MovieVideoScreen> {
  num _id;

  var _videoBloc;
  @override
  void initState() {
    _id = widget.id;
    _videoBloc = VideoBloc(_id);
    _videoBloc.eventSink.add(MovieVideoAction.Fetch);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Results>>(
        stream: _videoBloc.videoStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error ?? 'Error'),
            );
          }
          if (snapshot.hasData) {
            print(snapshot.data);
            return YoutubeVideoWidget(snapshot.data[0]);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
