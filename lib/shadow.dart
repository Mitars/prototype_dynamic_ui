import 'dart:ui' as ui;

import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  ShadowText(this.data, {this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Positioned(
            top: 2.0,
            left: 2.0,
            child: new Text(
              data,
              style: style.copyWith(color: Colors.black.withOpacity(0.25)),
            ),
          ),
          new BackdropFilter(
            filter: new ui.ImageFilter.blur(sigmaX: 0.1, sigmaY: 0.1),
            child: new Text(data, style: style),
          ),
        ],
      ),
    );
  }
}

class ShadowBoxText extends StatelessWidget {
  TextAlign textAlign;

  ShadowBoxText(this.data, {this.textAlign, this.style}) : assert(data != null);

  final String data;
  final TextStyle style;

  Widget build(BuildContext context) {
    return new ClipRect(
      child: new Stack(
        children: [
          new Container(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 0.5),
              child: new Text(
                data,
                style: style.copyWith(color: Colors.white),
              ),
            ),
            decoration: new BoxDecoration (
                color: new Color(0x22000000),
            ),
          ),
        ],
      ),
    );
  }
}

