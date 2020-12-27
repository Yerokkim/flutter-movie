import 'package:flutter/material.dart';
import 'package:movie_app/model/movie.dart';
import 'package:movie_app/screens/movie_detail_screen.dart';
import 'package:movie_app/widgets/average_tag_widget.dart';

class ItemCellWidget extends StatelessWidget {
  const ItemCellWidget(this.item);

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
        ]),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:movie_app/model/movie.dart';

// class ItemCellWidget extends StatelessWidget {
//   const ItemCellWidget(this.item);

//   @required
//   final Results item;
//   @override
//   Widget build(BuildContext context) {
//     return
//         // Card(
//         //   shape: RoundedRectangleBorder(
//         //     borderRadius: BorderRadius.circular(10.0),
//         //   ),
//         // color: Colors.grey[800],
//         // child:
//         Padding(
//       padding: EdgeInsets.all(1.0),
//       child: Container(
//         alignment: Alignment.center,
//         child: Column(
//           // crossAxisAlignment: CrossAxisAlignment.center,
//           // mainAxisAlignment: MainAxisAlignment.center,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Container(
//               child: AspectRatio(
//                 aspectRatio: 1,
//                 child: Image.network(
//                   "https://image.tmdb.org/t/p/original/" + item.posterPath,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             // Flexible(
//             //   child: AspectRatio(
//             //       aspectRatio: 2,
//             //       child: Image.network(
//             //         "https://image.tmdb.org/t/p/original/" + item.posterPath,
//             //         fit: BoxFit.cover,
//             //       )),
//             // ),
//             // Padding(
//             //   padding: EdgeInsets.all(10.0),
//             //   child: Text(
//             //     item.title,
//             //     textAlign: TextAlign.start,
//             //     style: TextStyle(fontSize: 20.0, color: Colors.white60),
//             //   ),
//             // )
//           ],
//         ),
//       ),
//     );
//     // );
//   }
// }
