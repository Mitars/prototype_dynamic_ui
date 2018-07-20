import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prototype_dynamic_ui/general/general.dart';
import 'package:prototype_dynamic_ui/model/food_details.dart';
import 'package:prototype_dynamic_ui/physics/custom_free_scroll_bounce.dart';
import 'package:prototype_dynamic_ui/ui/card/top_bottom_image_card.dart';
import 'package:prototype_dynamic_ui/ui/shadow/shadow.dart';
import 'package:prototype_dynamic_ui/ui/shadow/vertical_gradient.dart';
import 'package:prototype_dynamic_ui/ui/title_bar.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  runApp(new MaterialApp(
    showPerformanceOverlay: false,
    debugShowCheckedModeBanner: false,
    title: 'Flutter UI Test',
    theme: new ThemeData(
      primarySwatch: Colors.blue,
    ),
    home: new CoreApp(title: 'Flutter UI Test'),
  ));
}

class CoreApp extends StatefulWidget {
  CoreApp({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _CoreAppState createState() => new _CoreAppState();
}

class _CoreAppState extends State<CoreApp> {

  static const double menuHeight = 76.0;
  double scrollOffset = menuHeight;
  ScrollController _scrollController;

  List<FrontFoodCard> frontFoodCards;

  Future loadMenu() async {
    String jsonString = await rootBundle.loadString('assets/food.json');
    setState(() {
      var jsonQuestions = json.decode(jsonString);
      for (var question in jsonQuestions) {
        frontFoodCards.add(new FrontFoodCard.fromJson(question));
      }
    });
  }

  @override
  initState() {
    frontFoodCards = new List<FrontFoodCard>();
    this.loadMenu();
    _scrollController = new ScrollController(keepScrollOffset: false);
    _scrollController.addListener(() {
      scrollOffset = menuHeight - _scrollController.offset;
      this.setState(() {});
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("cookie2");
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            //color: new Color(0xFFF2F2F2),
            child: Column(
              children: <Widget>[
                Expanded(
                  child: Container(
                    color: new Color(0xFFF2F2F2),
                    child: new StaggeredGridView.countBuilder(
                      crossAxisCount: 1,
                      itemCount: frontFoodCards.length + 2,
                      physics: new CustomFreeScrollBouncePhysics(),
                      itemBuilder: (BuildContext context, int index) {
                        print("cookie");
                        if (index == 0 || index == frontFoodCards.length + 1) {
                          return new Container(height: 62.0);
                        }

                        return new FoodCard(frontFoodCards[index - 1].title,
                            topRightNumber: frontFoodCards[index - 1].price,
                            topLeftText: frontFoodCards[index - 1].restaurant,
                            imageUrl: frontFoodCards[index - 1].imageUrl,
                            topLeftIcon: Icons.fastfood,
                            height: 200.0,
                            description: frontFoodCards[index - 1].description);
                      },
                      controller: _scrollController,
                      staggeredTileBuilder: (index) => new StaggeredTile.fit(1),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Transform(
            transform: new Matrix4.translationValues(0.0, 0.0, 0.0),
            child: Container(
              height: scrollOffset < 0.0 ? 0.0 : scrollOffset,
              child: Center(
                child: Stack(
                  children: [
                    new Container(
                      decoration: const BoxDecoration(
                        image: const DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            'http://www.ukpreppersguide.co.uk/wp-content/uploads/2015/08/empty-plate.jpg',
                          ),
                        ),
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
                        transform: Matrix4.translationValues(
                            0.0, scrollOffset - 500.0, 0.0),
                        child: new ShadowText(
                          'Hungry?',
                          style: new TextStyle(
                            color: Colors.white,
                            fontSize: 22.0,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          Align(
              alignment: new Alignment(0.0, -1.0),
              child: new VerticalGradient(
                  menuHeight, new Color(0xDD000000), Colors.transparent)),
          Align(
            alignment: new Alignment(0.0, 1.0),
            child: new VerticalGradient(
                menuHeight, Colors.transparent, new Color(0xDD000000)),
          ),
          Align(
            alignment: new Alignment(-1.0, -1.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: new IconButton(
                  icon: new Icon(
                    Icons.menu,
                    color: new Color(0x77FFFFFF),
                    size: 32.0,
                  ),
                  onPressed: () {}),
            ),
          ),
          Align(
            alignment: new Alignment(1.0, -1.0),
            child: Padding(
              padding: const EdgeInsets.only(top: 4.0),
              child: new IconButton(
                  icon: new Icon(
                    Icons.settings,
                    color: new Color(0x77FFFFFF),
                    size: 28.0,
                  ),
                  onPressed: () {}),
            ),
          ),
          Transform(
            transform: Matrix4.translationValues(
                0.0, clampDown(scrollOffset - menuHeight, 0.0), 0.0),
            child: Container(
              height: menuHeight,
              child: new TitleBar(
                  'Mitar',
                  'https://lh3.googleusercontent.com/QGuHu5iREd_soS1IfdXO_P7cYaWcN-gbvtfVzJi4fAWmV-Y8bAF93xF2xW5BXnMMQao41w-cmzjB32nc=s139-rw',
                  'Last Ordered 09:54',
                  '520 rsd',
                  Icons.account_balance_wallet,
                  'Spagete Bolonjeze',
                  'https://img.taste.com.au/VFkGwzXU/w720-h480-cfill-q80/taste/2016/11/spaghetti-bolognese-106560-1.jpeg',
                  'Extra Food',
                  'Not feeling hungry? How about a refreshing salad?'),
            ),
          ),
        ],
      ),
    );
  }
}
