import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/ui/shadow.dart';

class TitleBar extends StatefulWidget {
  final AudioCache player;

  TitleBar(this.player);

  @override
  _TitleBarState createState() => _TitleBarState();
}

class _TitleBarState extends State<TitleBar> with TickerProviderStateMixin {
  AnimationController animationController;
  Animation<double> animation;

  @override
  void initState() {
    animationController =
        new AnimationController(duration: Duration(seconds: 20), vsync: this);
    animation =
        new CurvedAnimation(parent: animationController, curve: Curves.linear);
    animation.addListener(() {
      this.setState(() {});
    });

    animation.addStatusListener((AnimationStatus status) {});

    animationController.repeat();

    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 45.0),
          child: new Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 4.0, vertical: 5.0),
                child: InkWell(
                  child: new Container(
                    child: new CircleAvatar(
                      backgroundImage: NetworkImage(
                        'https://lh3.googleusercontent.com/QGuHu5iREd_soS1IfdXO_P7cYaWcN-gbvtfVzJi4fAWmV-Y8bAF93xF2xW5BXnMMQao41w-cmzjB32nc=s139-rw',
                      ),
                    ),
                    padding: const EdgeInsets.all(2.0),
                    decoration: new BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () {
                    widget.player.play('notification.wav');
                  },
                ),
              ),
              new Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: new Column(
                    children: <Widget>[
                      new Row(
                        children: <Widget>[
                          Expanded(
                            child: new Text(
                              'Mitar',
                              style: new TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          new Text(
                            'Last Ordered 09:54',
                            style: new TextStyle(
                              color: new Color(0xFFCCCCCC),
                            ),
                          ),
                        ],
                      ),
                      new Divider(
                        color: Colors.white,
                        height: 1.0,
                      ),
                      Align(
                        alignment: Alignment(1.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: new Icon(
                                Icons.account_balance_wallet,
                                color: new Color(0xFFe6c900),
                                size: 18.0,
                              ),
                            ),
                            new Text(
                              '520 rsd',
                              style: new TextStyle(
                                color: new Color(0xFFe6c900),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 9.0),
                child: new InkWell(
                  onTap: () {},
                  child: Container(
                    width: 55.0,
                    height: 40.0,
                    child: Stack(
                      children: [
                        Stack(
                          children: <Widget>[
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: new BoxDecoration(
                                image: new DecorationImage(
                                  image: NetworkImage(
                                      'https://img.taste.com.au/VFkGwzXU/w720-h480-cfill-q80/taste/2016/11/spaghetti-bolognese-106560-1.jpeg'),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius:
                                    BorderRadius.all(new Radius.circular(5.0)),
                                border: new Border.all(
                                  color: const Color(0xFFFFFFFF),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: new BoxDecoration(
                                gradient: new LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  stops: [0.0, 0.5, 1.0],
                                  colors: [
                                    new Color(0xFF000000),
                                    new Color(0x55000000),
                                    new Color(0x00000000),
                                  ],
                                ),
                                borderRadius:
                                    BorderRadius.all(new Radius.circular(5.0)),
                                border: new Border.all(
                                  color: const Color(0xFFFFFFFF),
                                  width: 2.0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3.5, vertical: 2.0),
                          child: new Text(
                            'Spagete Bolonjeze',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 9.0,
                            ),
                          ),
                        ),
                        Transform(
                          transform:
                              new Matrix4.translationValues(0.0, 10.0, 0.0),
                          child: Align(
                            alignment: new Alignment(0.0, 1.0),
                            child: new Text(
                              'Extra Food',
                              style: new TextStyle(
                                color: Colors.white,
                                fontSize: 8.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        OverflowBox(
          child: Transform(
            //TODO: Does not support dynamic sized text nor alignment
            transform: new Matrix4.translationValues(500 - animation.value * 1000, 30.0, 0.0),
            child: ShadowBoxText(
              'Not feeling hungry? How about a refreshing salad?',
              style: new TextStyle(
                color: Colors.white,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
