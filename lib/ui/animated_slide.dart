import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/general/animation.dart';

class AnimatedSlide extends StatefulWidget {
  final Widget child;
  final Offset offset;

  AnimatedSlide({@required this.child, @required this.offset});

  @override
  _AnimatedSlideState createState() => _AnimatedSlideState();
}

class _AnimatedSlideState extends State<AnimatedSlide>
    with SingleTickerProviderStateMixin {
  AnimationCore animation;

  @override
  void initState() {
    animation = new AnimationCore.defaultListener(
        this, new Duration(milliseconds: 1500), Curves.easeOut);
    animation.forward();
    super.initState();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Transform(
        transform: new Matrix4.translationValues(
          widget.offset.dx * (1 - animation.value),
          widget.offset.dy * (1 - animation.value),
          0.0,
        ),
        child: widget.child);
  }
}
