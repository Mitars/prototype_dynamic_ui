import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/ui/animated_rotation.dart';

class LoadingScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: new AnimatedRotation(
        child: new Text(
          "EB",
          style: new TextStyle(
            color: new Color(0xFFfb4b4f),
            fontSize: 62.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      color: Colors.black,
      constraints: BoxConstraints.expand(),
    );
  }
}
