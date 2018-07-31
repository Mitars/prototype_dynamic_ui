import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:prototype_dynamic_ui/food_card_scroller.dart';
import 'package:prototype_dynamic_ui/general/animation.dart';
import 'package:prototype_dynamic_ui/general/general.dart';
import 'package:prototype_dynamic_ui/model/food_details.dart';
import 'package:prototype_dynamic_ui/ui/animated_rotation.dart';
import 'package:prototype_dynamic_ui/ui/expanding_header.dart';
import 'package:prototype_dynamic_ui/ui/shadow/vertical_gradient.dart';
import 'package:prototype_dynamic_ui/ui/title_bar.dart';

void main() {
  runApp(new MaterialApp(
    showPerformanceOverlay: false,
    debugShowCheckedModeBanner: false,
    title: 'Flutter UI Test',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new CoreApp(title: 'Flutter UI Test'),
  ));
}

class CoreApp extends StatefulWidget {
  CoreApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CoreAppState createState() => new _CoreAppState();
}

class _CoreAppState extends State<CoreApp> with SingleTickerProviderStateMixin {
  static const double menuHeight = 76.0;
  static const double gradientHeight = 76.0;
  double scrollOffset = menuHeight;
  ScrollController _scrollController;
  List<FrontFoodCard> frontFoodCards;
  ImageProvider headerImage;

  AnimationCore animation;

  Future loadMenu() async {
    String jsonString = await rootBundle.loadString('assets/food.json');
    // TODO: Remove used for testing on device.
    await new Future.delayed(new Duration(milliseconds: 3000));
    setState(() {
      var jsonQuestions = json.decode(jsonString);
      for (var question in jsonQuestions) {
        var foodCard = new FrontFoodCard.fromJson(question);
        frontFoodCards.add(foodCard);
        precacheImage(new NetworkImage(foodCard.imageUrl), context)
            .whenComplete(() {
          foodCard.imageLoaded = true;
          loadingCompleted();
        });
      }
    });
  }

  @override
  initState() {
    frontFoodCards = new List<FrontFoodCard>();
    this.loadMenu();

    headerImage = NetworkImage(
      'http://www.ukpreppersguide.co.uk/wp-content/uploads/2015/08/empty-plate.jpg',
    );

    _scrollController = new ScrollController(keepScrollOffset: false);
    _scrollController.addListener(() {
      scrollOffset = menuHeight - _scrollController.offset;
      if (scrollOffset > 0.0) {
        this.setState(() {});
      }
    });

    animation = new AnimationCore.defaultListener(
        this, new Duration(milliseconds: 1000), Curves.linear);

    super.initState();
  }

  loadingCompleted() {
    if (frontFoodCards.every((card) => card.imageLoaded)) {
      animation.forward();
    }
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: [
          Container(
            child: new AnimatedRotation(
              child: new Text(
                "EB",
                style: new TextStyle(
                  color: new Color(0xFFfb4b4f),
                  fontSize: 62.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            color: Colors.black,
            constraints: BoxConstraints.expand(),
          ),
          ClipOval(
            clipper: new CircleRevealClipper(animation.value),
            child: Stack(
              children: <Widget>[
                Container(
                  //color: new Color(0xFFF2F2F2),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          color: new Color(0xFFF2F2F2),
                          child: new FoodCardScroller(
                            frontFoodCards: frontFoodCards,
                            scrollController: _scrollController,
                            topPadding: menuHeight,
                            bottomPadding: gradientHeight,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                new ExpandingHeader(
                    image: headerImage,
                    scrollOffset: scrollOffset,
                    text: 'Hungry?'),
                new VerticalGradient(
                  height: gradientHeight,
                  colorStart: new Color(0xDD000000),
                  colorEnd: Colors.transparent,
                ),
                new VerticalGradient(
                  height: gradientHeight,
                  colorStart: Colors.transparent,
                  colorEnd: new Color(0xDD000000),
                  alignment: Alignment.bottomCenter,
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: new IconButton(
                        icon: new Icon(
                          Icons.menu,
                          color: new Color(0x77FFFFFF),
                          size: 32.0,
                        ),
                        onPressed: () {}),
                  ),
                ),
                Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4.0),
                    child: new IconButton(
                        icon: new Icon(
                          Icons.settings,
                          color: new Color(0x77FFFFFF),
                          size: 28.0,
                        ),
                        onPressed: () {}),
                  ),
                ),
                Transform(
                  transform: Matrix4.translationValues(
                      0.0, clampDown(scrollOffset - menuHeight, 0.0), 0.0),
                  child: Container(
                    height: menuHeight,
                    child: new TitleBar(
                        'Mitar',
                        'https://lh3.googleusercontent.com/QGuHu5iREd_soS1IfdXO_P7cYaWcN-gbvtfVzJi4fAWmV-Y8bAF93xF2xW5BXnMMQao41w-cmzjB32nc=s139-rw',
                        'Last Ordered 09:54',
                        '520 rsd',
                        Icons.account_balance_wallet,
                        'Spagete Bolonjeze',
                        'https://img.taste.com.au/VFkGwzXU/w720-h480-cfill-q80/taste/2016/11/spaghetti-bolognese-106560-1.jpeg',
                        'Extra Food',
                        'Not feeling hungry? How about a refreshing salad?'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class CircleRevealClipper extends CustomClipper<Rect> {
  final double revealPercent;

  CircleRevealClipper(this.revealPercent);

  @override
  Rect getClip(Size size) {
    final epicenter = new Offset(size.width / 2, size.height / 2);

    double theta = atan(epicenter.dy / epicenter.dx);
    final distanceToCorner = epicenter.dy / sin(theta);

    final radius = distanceToCorner * revealPercent;
    final diameter = 2 * radius;

    return new Rect.fromLTWH(
        epicenter.dx - radius, epicenter.dy - radius, diameter, diameter);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return true;
  }
}
