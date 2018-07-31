import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/general/animation.dart';
import 'package:prototype_dynamic_ui/ui/shadow/shadow.dart';

class TickerMessage extends StatefulWidget {
  final String message;

  TickerMessage(this.message);

  @override
  _TickerMessageState createState() => _TickerMessageState();
}

class _TickerMessageState extends State<TickerMessage>
    with SingleTickerProviderStateMixin {
  AnimationCore animation;
  ScrollController scrollController;
  var initalLaunch;

  @override
  void initState() {
    scrollController = new ScrollController(keepScrollOffset: false);
    animation =
    new AnimationCore(this, new Duration(seconds: 10), Curves.linear);

    initalLaunch = true;
    animation.addBeforeDefaultListener(() {
      if (scrollController.position.maxScrollExtent != null) {
        if (initalLaunch) {
          initalLaunch = false;
          animation.duration(Duration(
              milliseconds: scrollController.position.maxScrollExtent.toInt() *
                  25));
          animation.reset();
          animation.repeat();
        }
        scrollController.jumpTo(
            scrollController.position.maxScrollExtent * animation.value);
      }
    });
    animation.repeat();

    super.initState();
  }

  @override
  void dispose() {
    animation.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery
        .of(context)
        .size
        .width;
    return Padding(
      padding: const EdgeInsets.only(top: 4.0),
      child: Container(
        width: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: scrollController,
          primary: false,
          child: Row(
            children: [
              Container(width: width),
              ShadowBoxText(
                widget.message,
                style: new TextStyle(
                  color: Colors.white,
                  fontSize: 12.0,
                ),
              ),
              Container(width: width),
            ],
          ),
        ),
      ),
    );
  }
}
