import 'package:flutter/material.dart';

class CircleRevealClipper extends CustomClipper<Rect> {
  /// The reveal percentage of the clip.
  ///
  /// The value goes from 0.0 to 1.0.
  final double revealPercent;

  /// A value which indicates if the clipper should reclip.
  final bool reclip;

  /// A value which indicates the amount of over clipping to use.
  ///
  /// The default is 1.0.
  final double overclip;

  CircleRevealClipper(this.revealPercent,
      {this.reclip = true, this.overclip = 1.0});

  @override
  Rect getClip(Size size) {
    final epicenter = new Offset(size.width / 2, size.height / 2);
    final radius = epicenter.distance * revealPercent * overclip;
    return new Rect.fromCircle(center: epicenter, radius: radius);
  }

  @override
  bool shouldReclip(CustomClipper<Rect> oldClipper) {
    return reclip;
  }
}
