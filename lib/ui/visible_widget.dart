import 'package:flutter/material.dart';

class VisibleWidget extends StatelessWidget {
  /// The widget to display when the condition is fulfilled.
  final Widget widget;

  /// The widget visibility.
  final bool visible;

  VisibleWidget(this.widget, this.visible);

  @override
  Widget build(BuildContext context) {
    return visible ? widget : new Container();
  }
}
