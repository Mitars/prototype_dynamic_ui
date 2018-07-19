import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/ui/shadow.dart';

class FoodCard extends StatefulWidget {
  final String title;
  final IconData topLeftIcon; // TODO: Swap with restaurant logo.
  final String topLeftText;
  final double topRightNumber;
  final String imageUrl;
  final String description;
  final double height;

  FoodCard(this.title,
      {this.topRightNumber,
      this.topLeftText,
      this.imageUrl,
      this.topLeftIcon,
      this.height,
      this.description});

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> with SingleTickerProviderStateMixin {
  Random random = new Random();

  AnimationController controller;
  Animation<double> animation;

  double animationValue = 0.0;
  ForwardBackwardState forwardBackwardState;

  @override
  void initState() {
    forwardBackwardState = ForwardBackwardState.forward;

    controller = new AnimationController(duration: new Duration(milliseconds: 5000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addListener(() {
      this.setState(() {
        if (animation.isCompleted) {
          switch(forwardBackwardState)
          {
            case ForwardBackwardState.forward:
              controller.duration  = new Duration(milliseconds: 2000 + random.nextInt(3000));
              forwardBackwardState = ForwardBackwardState.end;
              break;

            case ForwardBackwardState.end:
              controller.duration  = new Duration(milliseconds: 1000 + random.nextInt(5000));
              forwardBackwardState = ForwardBackwardState.backward;
              break;

            case ForwardBackwardState.backward:
              controller.duration  = new Duration(milliseconds: 2000 + random.nextInt(3000));
              forwardBackwardState = ForwardBackwardState.start;
              break;

            case ForwardBackwardState.start:
              controller.duration  = new Duration(milliseconds: 1000 + random.nextInt(5000));
              forwardBackwardState = ForwardBackwardState.forward;
              break;
          }

          controller.reset();
          controller.forward();
        }
        
        switch(forwardBackwardState)
        {
          case ForwardBackwardState.forward:
            animationValue = animation.value;
            break;

          case ForwardBackwardState.backward:
            animationValue = 1.0 - animation.value;
            break;

          default:
            break;
        }
      });
    });
    animation.addStatusListener((AnimationStatus status) {});

    controller.forward();

    super.initState();
  }

  bool animateForward;

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
      child: Container(
        height: 200.0,
        child: new Card(
          child: Column(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 8.0),
                child: new Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: new Icon(
                        widget.topLeftIcon,
                        color: Colors.blueAccent,
                        size: 16.0,
                      ),
                    ),
                    new Expanded(
                      child: new Text(
                        widget.topLeftText,
                        style: new TextStyle(
                          color: new Color(0xFF555555),
                        ),
                      ),
                    ),
                    Align(
                      child: new Text(
                        '${widget.topRightNumber.toStringAsFixed(0)} rsd',
                        textAlign: TextAlign.right,
                        style: new TextStyle(
                            color: Colors.blueAccent, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: new Container(
                  decoration: new BoxDecoration(
                    image: new DecorationImage(
                      alignment: new Alignment(0.0, animationValue * 2.0 - 1.0),
                      image: NetworkImage(
                        widget.imageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Align(
                    alignment: Alignment(-1.0, 1.0),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 4.0),
                      child: new ShadowText(
                        widget.title,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24.0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: new Alignment(1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Text(
                    widget.description != null ? widget.description : '',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum ForwardBackwardState {
  forward,
  start,
  backward,
  end,
}
