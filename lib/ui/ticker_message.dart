import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/ui/shadow/shadow.dart';

class TickerMessage extends StatefulWidget {
  final String message;

  TickerMessage(this.message);

  @override
  _TickerMessageState createState() => _TickerMessageState();
}

class _TickerMessageState extends State<TickerMessage>
    with SingleTickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController =
        new AnimationController(duration: Duration(seconds: 20), vsync: this);
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.linear);
    animation.addListener(() {
      this.setState(() {});
    });

    animation.addStatusListener((AnimationStatus status) {});

    animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return OverflowBox(
      child: Transform(
        //TODO: Does not support dynamic sized text nor alignment
        transform: new Matrix4.translationValues(
            500 - animation.value * 1000, 30.0, 0.0),
        child: ShadowBoxText(
          widget.message,
          style: new TextStyle(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }
}
