import 'dart:math';

import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/shadow.dart';

class FoodCard extends StatefulWidget {

  final String restaurant;
  final double price;
  final String title;
  final String url;
  final String description;
  final double height;

  // Swap with restaurant logo.
  final IconData icon;

  FoodCard(this.title, this.price, this.restaurant, this.url, this.icon, {this.height, this.description});

  @override
  _FoodCardState createState() => _FoodCardState();
}

class _FoodCardState extends State<FoodCard> with TickerProviderStateMixin {

  Random random = new Random();

  AnimationController controller;
  Animation<double> animation;

  AnimationController controllerFreeze;
  Animation<double> animationFreeze;

  AnimationController controllerBack;
  Animation<double> animationBack;

  double animationValue = 0.0;

  AnimationController nextController;

  @override
  void initState() {
    controller = new AnimationController(duration: new Duration(milliseconds: 5000), vsync: this);
    animation = new CurvedAnimation(parent: controller, curve: Curves.easeInOut);
    animation.addListener(() {
      this.setState(() {
        animationValue = animation.value;
        if (animation.isCompleted)
        {
          nextController = controllerBack;
          controllerFreeze.duration = new Duration(milliseconds: 500 + random.nextInt(5000));
          controllerFreeze.reset();
          controllerFreeze.forward();
        }
      });
    });
    animation.addStatusListener((AnimationStatus status) {});

    controllerBack = new AnimationController(duration: new Duration(milliseconds: 5000), vsync: this);
    animationBack = new CurvedAnimation(parent: controllerBack, curve: Curves.easeInOut);
    animationBack.addListener(() {
      this.setState(() {
        animationValue = 1.0 - animationBack.value;
        if (animationBack.isCompleted)
        {
          nextController = controller;
          controllerFreeze.duration = new Duration(milliseconds: 500 + random.nextInt(5000));
          controllerFreeze.reset();
          controllerFreeze.forward();
        }
      });
    });
    animationBack.addStatusListener((AnimationStatus status) {});

    controllerFreeze = new AnimationController(duration: new Duration(milliseconds: 500 + random.nextInt(5000)), vsync: this);
    animationFreeze = new CurvedAnimation(parent: controllerFreeze, curve: Curves.linear);
    animationFreeze.addListener(() {
      this.setState(() {
        if (animationFreeze.isCompleted)
      {
          nextController.reset();
          nextController.forward();
        }
      });
    });
    animationFreeze.addStatusListener((AnimationStatus status) {});

    nextController = controller;
    controllerFreeze.forward();

    super.initState();
  }

  bool animateForward;

  @override
  void dispose() {
    controller.dispose();
    controllerBack.dispose();
    controllerFreeze.dispose();

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
                        widget.icon,
                        color: Colors.blueAccent,
                        size: 16.0,
                      ),
                    ),
                    new Expanded(
                      child: new Text(
                        widget.restaurant,
                        style: new TextStyle(
                          color: new Color(0xFF555555),
                        ),
                      ),
                    ),
                    Align(
                      child: new Text(
                        '${widget.price.toStringAsFixed(0)} rsd',
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
                        widget.url,
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
