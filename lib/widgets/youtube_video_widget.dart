import 'package:flutter/material.dart';
import 'package:movie_app/model/movieVideo.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubeVideoWidget extends StatefulWidget {
  const YoutubeVideoWidget(this.video);

  @required
  final Results video;

  @override
  _YoutubeVideoWidgetState createState() => _YoutubeVideoWidgetState();
}

class _YoutubeVideoWidgetState extends State<YoutubeVideoWidget> {
  String _key;

  @override
  void initState() {
    _key = widget.video.key;

    videoPlay(_key);

    super.initState();
  }

  YoutubePlayerController _controller;
  void videoPlay(String key) {
    _controller = YoutubePlayerController(
      initialVideoId: key,
      flags: YoutubePlayerFlags(autoPlay: false, isLive: false, mute: true),
    );
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Column(
          children: [
            player,
          ],
        );
      },
    );
  }
}
