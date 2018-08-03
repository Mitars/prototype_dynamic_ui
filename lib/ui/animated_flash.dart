import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/general/animation.dart';

class AnimatedFlash extends StatefulWidget {
  final Widget child;

  AnimatedFlash({this.child});

  @override
  _AnimatedFlashState createState() => _AnimatedFlashState();
}

class _AnimatedFlashState extends State<AnimatedFlash>
    with SingleTickerProviderStateMixin {
  AnimationCore animation;

  @override
  void initState() {
    animation = new AnimationCore.defaultListener(
        this, new Duration(milliseconds: 2000), Curves.linear);
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
    return Opacity(
        opacity: (animation.value - 0.5).abs() * 2, child: widget.child);
  }
}
