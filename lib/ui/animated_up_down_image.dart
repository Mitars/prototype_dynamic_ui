import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/general/animation.dart';
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
  AnimationCore animation;
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

    animation = new AnimationCore(
        this, new Duration(milliseconds: 5000), Curves.easeInOut);
    animation.addListener(() {
      if (animation.isCompleted) {
        var animationIndex =
        forwardBackwardState.index + 1 >= ForwardBackwardState.values.length
            ? 0
            : forwardBackwardState.index + 1;
        forwardBackwardState = ForwardBackwardState.values[animationIndex];
        animation.duration(animationStates[forwardBackwardState]());
        animation.reset();
        animation.forward();
      }

      var animationValueOld = animation.value;

      if (forwardBackwardState == ForwardBackwardState.forward) {
        animation.value = animation.animatedValue;
      } else if (forwardBackwardState == ForwardBackwardState.backward) {
        animation.value = 1.0 - animation.animatedValue;
      }

      if (animationValueOld != animation.value) {
        this.setState(() {});
      }
    });

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
    return Container(
      decoration: new BoxDecoration(
        image: new DecorationImage(
          alignment: new Alignment(0.0, animation.value * 2.0 - 1.0),
          image: image,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
