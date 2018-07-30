import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedRotationImage extends StatefulWidget {
  @override
  _AnimatedRotationImageState createState() => _AnimatedRotationImageState();
}

class _AnimatedRotationImageState extends State<AnimatedRotationImage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    controller = new AnimationController(
        duration: new Duration(milliseconds: 5000), vsync: this);
    animation =
        new CurvedAnimation(parent: controller, curve: Curves.elasticInOut);
    animation.addListener(() {
      this.setState(() {});
    });
    animation.addStatusListener((AnimationStatus status) {});

    controller.repeat();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Transform.rotate(
        angle: animation.value * 2 * pi,
        child: new Text(
          "Now Loading",
          style: new TextStyle(color: Colors.white, fontSize: 32.0),
        ),
      ),
    );
  }
}
