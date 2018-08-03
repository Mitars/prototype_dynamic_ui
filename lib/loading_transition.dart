import 'package:flutter/cupertino.dart';
import 'package:prototype_dynamic_ui/general/animation.dart';
import 'package:prototype_dynamic_ui/ui/reveal_circle_painter.dart';
import 'package:prototype_dynamic_ui/ui/visible_widget.dart';

class LoadingTransition extends StatefulWidget {
  @override
  _LoadingTransitionState createState() => _LoadingTransitionState();
}

class _LoadingTransitionState extends State<LoadingTransition>
    with SingleTickerProviderStateMixin {
  AnimationCore animation;

  @override
  void initState() {
    animation = new AnimationCore.defaultListener(
        this, new Duration(milliseconds: 800), Curves.linear);
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
    return VisibleWidget(
        new CustomPaint(
            painter: new RevealCirclePainter(
              radiusPercent: animation.value,
            ),
            child: Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height)),
        animation.isStarted);
  }
}
