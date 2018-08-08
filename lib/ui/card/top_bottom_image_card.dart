import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/ui/animated_up_down_image.dart';
import 'package:prototype_dynamic_ui/ui/shadow/shadow.dart';

class TopBottomImageCard extends StatelessWidget {
  final String title;
  final IconData topLeftIcon; // TODO: Swap image.
  final String topLeftText;
  final String topRightText;
  final String imageUrl;
  final String description;
  final double height;

  TopBottomImageCard(this.title,
      {this.topRightText,
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
                        topRightText,
                        textAlign: TextAlign.right,
                        style: new TextStyle(
                            color: Colors.blueAccent, fontSize: 12.0),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Stack(
                  children: [
                    AnimatedUpDownImage(imageUrl),
                    Container(
                      alignment: Alignment.bottomLeft,
                      padding: EdgeInsets.only(left: 9.0, bottom: 3.0),
                      child: ShadowText(
                        title,
                        style: new TextStyle(
                          color: Colors.white,
                          fontSize: 29.0,
                        ),
                      ),
                    ),
                  ],
                ),
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
