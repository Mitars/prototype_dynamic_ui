import 'package:flutter/material.dart';

class RevealCirclePainter extends CustomPainter {
  Offset centerOffset;
  Paint _paint;
  final double radiusPercent;
  Offset _modifiedOffset;

  RevealCirclePainter(
      {this.radiusPercent, this.centerOffset, color = Colors.black}) {
    _paint = new Paint();
    _paint.color = color;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (centerOffset == null) {
      centerOffset = new Offset(size.width / 2, size.height / 2);
    }

    if (_modifiedOffset == null) {
      var x = centerOffset.dx > size.width / 2
          ? centerOffset.dx
          : size.width - centerOffset.dx;
      var y = centerOffset.dy > size.height / 2
          ? centerOffset.dy
          : size.height - centerOffset.dy;
      _modifiedOffset = new Offset(x, y);
    }

    _maskCircle(
        canvas, size, centerOffset, _modifiedOffset.distance, radiusPercent);
    canvas.drawRect(
        new Rect.fromLTWH(0.0, 0.0, size.width, size.height), _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }

  _maskCircle(Canvas canvas, Size size, Offset offset, double radius,
      double radiusPercent) {
    var path = new Path();
    path.fillType = PathFillType.evenOdd;
    path.addRect(new Rect.fromLTWH(0.0, 0.0, size.width, size.height));
    path.addOval(
        new Rect.fromCircle(center: offset, radius: radius * radiusPercent));
    canvas.clipPath(path);
  }
}
