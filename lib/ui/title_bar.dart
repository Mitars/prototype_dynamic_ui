import 'package:flutter/material.dart';
import 'package:prototype_dynamic_ui/ui/ticker_message.dart';

class TitleBar extends StatelessWidget {
  final String userTitle;
  final String userImageUrl;
  final String pointText;
  final IconData pointIcon;
  final String subText;
  final String selectionTitle;
  final String selectionImageUrl;
  final String selectionSubText;
  final String tickerMessage;

  NetworkImage userImage;
  NetworkImage orderImage;

  TitleBar(this.userTitle,
      this.userImageUrl,
      this.subText,
      this.pointText,
      this.pointIcon,
      this.selectionTitle,
      this.selectionImageUrl,
      this.selectionSubText,
      this.tickerMessage);

  @override
  Widget build(BuildContext context) {
    userImage = NetworkImage(userImageUrl);
    orderImage = NetworkImage(selectionImageUrl);

    return Column(
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
                      backgroundImage: userImage,
                    ),
                    padding: const EdgeInsets.all(2.0),
                    decoration: new BoxDecoration(
                      color: const Color(0xFFFFFFFF),
                      shape: BoxShape.circle,
                    ),
                  ),
                  onTap: () {},
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
                              userTitle,
                              style: new TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                          new Text(
                            subText,
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
                                pointIcon,
                                color: new Color(0xFFe6c900),
                                size: 18.0,
                              ),
                            ),
                            new Text(
                              pointText,
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
                                  image: orderImage,
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
                            selectionTitle,
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
                              selectionSubText,
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
        new TickerMessage(tickerMessage),
      ],
    );
  }
}
