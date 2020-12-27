import 'package:flutter/material.dart';

class TitleDescriptionWidget extends StatelessWidget {
  const TitleDescriptionWidget(this.title, this.description);

  @required
  final String title;
  final String description;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 20,
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Column(
          children: <Widget>[
            Text(
              title,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30.0,
                  fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 30.0,
            ),
            Text(
              description,
              style: TextStyle(
                color: Colors.white,
                fontSize: 17.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
