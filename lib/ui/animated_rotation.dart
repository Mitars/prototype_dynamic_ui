import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/general/animation.dart';

class AnimatedRotation extends StatefulWidget {
  final Widget child;

  AnimatedRotation({this.child});

  @override
  _AnimatedRotationState createState() => _AnimatedRotationState();
}

class _AnimatedRotationState extends State<AnimatedRotation>
    with SingleTickerProviderStateMixin {
  AnimationCore animation;

  @override
  void initState() {
    animation = new AnimationCore.defaultListener(
        this, new Duration(milliseconds: 4000), Curves.elasticInOut);
    animation.repeat();

    super.initState();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Transform.rotate(
        angle: animation.value * 2 * pi,
        child: widget.child,
      ),
    );
  }
}
