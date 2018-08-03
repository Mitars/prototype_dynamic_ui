import 'package:flutter/material.dart';

class ToggleWidget extends StatelessWidget {
  /// The widget to display when the condition is fulfilled.
  final Widget widgetEnabled;

  /// The widget to display when the condition is not fulfilled.
  final Widget widgetDisabled;

  /// The widget visibility.
  final bool visible;

  ToggleWidget({this.widgetEnabled, this.widgetDisabled, this.visible});

  @override
  Widget build(BuildContext context) {
    return visible ? widgetEnabled : widgetDisabled;
  }
}
