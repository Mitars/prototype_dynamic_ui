import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/ui/image_button.dart';

class NavigationMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(padding: const EdgeInsets.all(0.0)),
            ImageButton(
                text: "Home",
                icon: Icons.favorite,
                color: Colors.white,
                selected: true),
            ImageButton(
                text: "Restaurants",
                icon: Icons.home,
                color: new Color(0x99FFFFFF)),
            ImageButton(
                text: "Courses",
                icon: Icons.restaurant_menu,
                color: new Color(0x99FFFFFF)),
            Padding(padding: const EdgeInsets.all(0.0)),
          ],
        ),
      ),
    );
  }
}
