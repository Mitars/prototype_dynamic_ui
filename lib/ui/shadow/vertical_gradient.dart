import 'package:flutter/material.dart';

class VerticalGradient extends StatelessWidget {
  final double height;
  final Color colorStart;
  final Color colorEnd;
  final Alignment alignment;

  VerticalGradient({@required this.height,
    @required this.colorStart,
    @required this.colorEnd,
    this.alignment});

  @override
  Widget build(BuildContext context) {
    return new Align(
      alignment: alignment ?? Alignment.topCenter,
      child: IgnorePointer(
        child: Container(
          height: height,
          decoration: new BoxDecoration(
            gradient: new LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.0, 1.0],
              colors: [colorStart, colorEnd],
            ),
          ),
        ),
      ),
    );
  }
}
