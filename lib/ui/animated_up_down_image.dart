import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/general/general.dart';

enum ForwardBackwardState {
  forward,
  start,
  backward,
  end,
}

class AnimatedUpDownImage extends StatefulWidget {
  final String imageUrl;

  AnimatedUpDownImage(this.imageUrl);

  @override
  _AnimatedUpDownImageState createState() => _AnimatedUpDownImageState();
}

class _AnimatedUpDownImageState extends State<AnimatedUpDownImage>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  double animationValue = 0.0;
  double animationValueOld = 0.0;
  ForwardBackwardState forwardBackwardState;

  NetworkImage image;

  @override
  void initState() {
    image = NetworkImage(
      widget.imageUrl,
    );

    var animationStates =
    new EqualityMap<ForwardBackwardState, Duration Function()>.from(
        const DefaultEquality(), {
      ForwardBackwardState.start: () =>
      new Duration(milliseconds: randomIntOffsetted(2000, 3000)),
      ForwardBackwardState.forward: () =>
      new Duration(milliseconds: randomIntOffsetted(1000, 5000)),
      ForwardBackwardState.end: () =>
      new Duration(milliseconds: randomIntOffsetted(2000, 3000)),
      ForwardBackwardState.backward: () =>
      new Duration(milliseconds: randomIntOffsetted(1000, 5000)),
    });

    forwardBackwardState = ForwardBackwardState.forward;

    controller = new AnimationController(
        duration: new Duration(milliseconds: 5000), vsync: this);
    animation =
        new CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addListener(() {
      if (animation.isCompleted) {
        var animationIndex =
        forwardBackwardState.index + 1 >= ForwardBackwardState.values.length
            ? 0
            : forwardBackwardState.index + 1;
        forwardBackwardState = ForwardBackwardState.values[animationIndex];
        controller.duration = animationStates[forwardBackwardState]();
        controller.reset();
        controller.forward();
      }

      animationValueOld = animationValue;

      if (forwardBackwardState == ForwardBackwardState.forward) {
        animationValue = animation.value;
      } else if (forwardBackwardState == ForwardBackwardState.backward) {
        animationValue = 1.0 - animation.value;
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
