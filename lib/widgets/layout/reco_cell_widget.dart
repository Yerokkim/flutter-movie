import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/widgets/average_tag_widget.dart';

class RecoCellWidget extends StatelessWidget {
  const RecoCellWidget(this.item);

  @required
  final Results item;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(item.id);
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailScreen(item),
          ),
        );
      },
      child: Card(
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Stack(children: <Widget>[
          Image.network(
            "https://image.tmdb.org/t/p/original/" + item.posterPath,
            width: 230,
            height: 400,
            fit: BoxFit.cover,
          ),
          AverageTagWidget(item.voteAverage),
          // FittedBox(
          //   fit: BoxFit.scaleDown,
          //   child: Text(
          //     item.title,
          //     style: TextStyle(color: Colors.white),
          //   ),
          // ),
        ]),
      ),
    );
  }
}
