import 'package:flutter/material.dart';

class AverageTagWidget extends StatelessWidget {
  const AverageTagWidget(this.average);

  @required
  final double average;
  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 16,
      left: 140,
      child: Container(
        height: 25,
        width: 80,
        decoration: BoxDecoration(
          color: Colors.yellow,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
            ),
          ],
        ),
        child: Center(
          child: Text(
            average.toString(),
            style: TextStyle(color: Colors.black),
          ),
        ),
      ),
    );
  }
}
