import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/ui/animated_image.dart';

class FoodCard extends StatelessWidget {
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
                        topLeftIcon,
                        color: Colors.blueAccent,
                        size: 16.0,
                      ),
                    ),
                    new Expanded(
                      child: new Text(
                        topLeftText,
                        style: new TextStyle(
                          color: new Color(0xFF555555),
                        ),
                      ),
                    ),
                    Align(
                      child: new Text(
                        '${topRightNumber.toStringAsFixed(0)} rsd',
                        textAlign: TextAlign.right,
                        style: new TextStyle(
                            color: Colors.blueAccent, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: AnimatedImage(imageUrl),
              ),
              Align(
                alignment: new Alignment(1.0, 0.0),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: new Text(
                    description != null ? description : '',
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
