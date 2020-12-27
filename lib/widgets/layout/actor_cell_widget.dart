import 'package:flutter/material.dart';
import 'package:movie_app/model/movieActors.dart';

class ActorCellWidget extends StatelessWidget {
  const ActorCellWidget(this.actors);

  @required
  final Cast actors;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      child: Column(
        children: <Widget>[
          Card(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: NetworkImage(
                    "https://image.tmdb.org/t/p/original/" + actors.profilePath,
                  ),
                ),
              ),
            ),
          ),
          // Text(
          //   actors.character,
          //   style: TextStyle(color: Colors.white, fontSize: 15.0),
          // ),
          Text(
            actors.originalName,
            style: TextStyle(color: Colors.white, fontSize: 13.0),
          ),
        ],
      ),
    );
  }
}
