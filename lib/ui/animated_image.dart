import 'dart:math';

import 'package:flutter/material.dart';

enum ForwardBackwardState {
  forward,
  start,
  backward,
  end,
}

class AnimatedImage extends StatefulWidget {
  final String imageUrl;

  AnimatedImage(this.imageUrl);

  @override
  _AnimatedImageState createState() => _AnimatedImageState();
}

class _AnimatedImageState extends State<AnimatedImage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  double animationValue = 0.0;
  double animationValueOld = 0.0;
  ForwardBackwardState forwardBackwardState;

  Random random = new Random();

  NetworkImage image;

  @override
  void initState() {
    image = NetworkImage(
      widget.imageUrl,
    );

    forwardBackwardState = ForwardBackwardState.forward;

    controller = new AnimationController(
        duration: new Duration(milliseconds: 5000), vsync: this);
    animation =
        new CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addListener(() {
      animationValueOld = animationValue;
      if (animation.isCompleted) {
        switch (forwardBackwardState) {
          case ForwardBackwardState.forward:
            controller.duration =
            new Duration(milliseconds: 2000 + random.nextInt(3000));
            forwardBackwardState = ForwardBackwardState.end;
            break;

          case ForwardBackwardState.end:
            controller.duration =
            new Duration(milliseconds: 1000 + random.nextInt(5000));
            forwardBackwardState = ForwardBackwardState.backward;
            break;

          case ForwardBackwardState.backward:
            controller.duration =
            new Duration(milliseconds: 2000 + random.nextInt(3000));
            forwardBackwardState = ForwardBackwardState.start;
            break;

          case ForwardBackwardState.start:
            controller.duration =
            new Duration(milliseconds: 1000 + random.nextInt(5000));
            forwardBackwardState = ForwardBackwardState.forward;
            break;
        }

        controller.reset();
        controller.forward();
      }

      switch (forwardBackwardState) {
        case ForwardBackwardState.forward:
          animationValue = animation.value;
          break;

        case ForwardBackwardState.backward:
          animationValue = 1.0 - animation.value;
          break;

        default:
          break;
      }

      if (animationValueOld != animationValue) {
        this.setState(() {});
      }
    });
    animation.addStatusListener((AnimationStatus status) {});

    controller.forward();

    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          alignment: new Alignment(0.0, animationValue * 2.0 - 1.0),
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
