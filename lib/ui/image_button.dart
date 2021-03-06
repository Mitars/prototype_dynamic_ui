import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/ui/animated_flash.dart';
import 'package:prototype_dynamic_ui/ui/shadow/shadow.dart';
import 'package:prototype_dynamic_ui/ui/toggle_widget.dart';

class ImageButton extends StatelessWidget {
  String text;
  Color color;
  var icon;
  bool selected;

  ImageButton(
      {this.text, this.icon, this.color = Colors.white, this.selected = false});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6.0, vertical: 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Container(
            width: 42.0,
            height: 42.0,
            child: new Icon(
              icon,
              color: color,
              size: 42.0,
            ),
            decoration: new BoxDecoration(
              boxShadow: [
                new BoxShadow(
                  color: new Color(0x33000000),
                  offset: new Offset(0.0, 20.0),
                  blurRadius: 15.0,
                ),
              ],
            ),
          ),
          new ShadowText(
            text,
            style: new TextStyle(
              color: color,
              fontSize: 11.0,
            ),
          ),
          ToggleWidget(
              widgetEnabled: AnimatedFlash(
                child: new Container(
                  height: 5.0,
                  width: 60.0,
                  color: color,
                ),
              ),
              widgetDisabled: new Container(
                height: 5.0,
                width: 60.0,
              ),
              visible: selected),
        ],
      ),
    );
  }
}
