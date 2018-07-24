import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/general/general.dart';
import 'package:prototype_dynamic_ui/ui/shadow/shadow.dart';

class ExpandingHeader extends StatelessWidget {
  final double scrollOffset;
  final ImageProvider image;

  const ExpandingHeader({this.image, this.scrollOffset});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: scrollOffset < 0.0 ? 0.0 : scrollOffset,
      child: Center(
        child: Stack(
          children: [
            new Container(
              decoration: new BoxDecoration(
                image: new DecorationImage(fit: BoxFit.cover, image: image),
              ),
            ),
            Opacity(
              opacity: clamp(1.0 - (scrollOffset * 0.0015), 0.0, 1.0),
              child: Container(
                color: new Color(0x77000000),
              ),
            ),
            Align(
              alignment: new Alignment(0.0, -0.5),
              child: Transform(
                transform:
                    Matrix4.translationValues(0.0, scrollOffset - 500.0, 0.0),
                child: new ShadowText(
                  'Hungry?',
                  style: new TextStyle(
                    color: Colors.white,
                    fontSize: 22.0,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
