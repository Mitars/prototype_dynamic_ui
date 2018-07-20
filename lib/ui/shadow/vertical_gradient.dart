import 'package:flutter/material.dart';

class VerticalGradient extends StatelessWidget {
  final double menuHeight;
  final Color colorStart;
  final Color colorEnd;

  VerticalGradient(this.menuHeight, this.colorStart, this.colorEnd);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        height: menuHeight,
        decoration: new BoxDecoration(
          gradient: new LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.0, 1.0],
            colors: [colorStart, colorEnd],
          ),
        ),
      ),
    );
  }
}
