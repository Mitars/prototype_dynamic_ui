import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:prototype_dynamic_ui/food_card.dart';
import 'package:prototype_dynamic_ui/shadow.dart';
import 'package:prototype_dynamic_ui/title_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

void main() {
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

  runApp(new MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'CraftRounded',
      ),
      home: new MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    AudioCache player = new AudioCache();
    // TODO: stutter, does not stop music when the app goes to the background
    //player.loop('menu.mp3');

    return new Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            color: new Color(0xFFF2F2F2),
            child: Transform(
              transform: new Matrix4.translationValues(0.0, 0.0, 0.0),
              child: new StaggeredGridView.count(
                physics: new BouncingScrollPhysics(),
                crossAxisCount: 1,
                staggeredTiles: const <StaggeredTile>[
                  const StaggeredTile.count(1, 1),
                  const StaggeredTile.count(1, 0.5),
                  const StaggeredTile.count(1, 0.5),
                  const StaggeredTile.count(1, 0.5),
                  const StaggeredTile.count(1, 0.5),
                ],
                children: [
                  Transform(
                    transform: new Matrix4.translationValues(0.0, -222.0, 0.0),
                    child: Stack(
                      children: [
                        new Image.network(
                          'http://www.ukpreppersguide.co.uk/wp-content/uploads/2015/08/empty-plate.jpg',
                          fit: BoxFit.cover,
                        ),
                        Align(
                          alignment: new Alignment(0.0, -0.5),
                          child: new ShadowText(
                            'Hungry?',
                            style: new TextStyle(
                              color: Colors.white,
                              fontSize: 22.0,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Transform(
                    transform: new Matrix4.translationValues(0.0, -360.0, 0.0),
                    child: new FoodCard(
                        'Spagete Bolonjeze',
                        350.0,
                        'Extra Food',
                        'https://img.taste.com.au/VFkGwzXU/w720-h480-cfill-q80/taste/2016/11/spaghetti-bolognese-106560-1.jpeg',
                        Icons.fastfood,
                        height: 200.0,
                        description:
                            'Spagete, Bolonjez sos (Paradajz, Luk, Mleveno Meso)'),
                  ),
                  Transform(
                    transform: new Matrix4.translationValues(0.0, -360.0, 0.0),
                    child: new FoodCard(
                        'Capricoza',
                        350.0,
                        'Big Pizza',
                        'https://recipes.timesofindia.com/photo/53110049.cms',
                        Icons.local_pizza,
                        height: 200.0,
                        description: 'Testo, Pecurke, Sunka'),
                  ),
                  Transform(
                    transform: new Matrix4.translationValues(0.0, -360.0, 0.0),
                    child: new FoodCard(
                        'Paradajz Corba',
                        120.0,
                        'Extra Food',
                        'https://atmedia.imgix.net/c0d49cd0c7ff33b17764502ed22777d702599990?w=1500&fit=max',
                        Icons.fastfood,
                        height: 200.0,
                        description: 'Paradajz, zacini'),
                  ),
                  Transform(
                    transform: new Matrix4.translationValues(0.0, -360.0, 0.0),
                    child: new FoodCard(
                        'Karadjordjeva Snicla',
                        290.0,
                        'Extra Food',
                        'https://belgrade-beat.rs/photos/articles/366/c-1515762102.jpg',
                        Icons.fastfood,
                        description: 'Svinsko meso'),
                  ),
                  Transform(
                    transform: new Matrix4.translationValues(0.0, -360.0, 0.0),
                    child: new FoodCard(
                        'Burito',
                        253.2,
                        'Tortilja Kasa',
                        'https://img.sndimg.com/food/image/upload/w_896,h_504,c_fill,fl_progressive,q_80/v1/img/recipes/60/71/4/GidRq10yRvmCa76hJBkD_burrito4.jpg',
                        Icons.restaurant,
                        description:
                            'Tortilja, Pasulj, Mleveno meso, Paprika, Luk'),
                  ),
                  Transform(
                    transform: new Matrix4.translationValues(0.0, -360.0, 0.0),
                    child: new FoodCard(
                        'Hamburger',
                        400.0,
                        'Toster Bar',
                        'https://www.kraftlokator.com/wp-content/uploads/2017/04/Toster-Bar-4.jpg',
                        Icons.restaurant,
                        description: 'Junece meso, Krastavci, Ketchup'),
                  ),
                  Transform(
                    transform: new Matrix4.translationValues(0.0, -360.0, 0.0),
                    child: new FoodCard(
                        'Vocna Torta',
                        220.0,
                        'Hedone',
                        'https://minimalistbaker.com/wp-content/uploads/2018/02/1-Bowl-Vegan-Gluten-Free-Vanilla-Cake-Egg-free-oil-free-fluffy-perfectly-sweet-SO-delicious-vegan-glutenfree-cake-recipe-plantbased-minimalistbaker-9.jpg',
                        Icons.cake,
                        description: 'Jagode, Secer, Puding, Slag'),
                  ),
                  Transform(
                    transform: new Matrix4.translationValues(0.0, -360.0, 0.0),
                    child: new FoodCard(
                        'Test Card',
                        999.0,
                        'Test',
                        'https://globalfm.org/DEV/wp-content/uploads/2017/01/test.gif',
                        Icons.bug_report,
                        description:
                            'Test card 1.0, Value 1, Value 2, Value 3, Value 4, Value 5, Value 1, Value 2, Value 3, Value 4, Value 5'),
                  ),
                ],
              ),
            ),
          ),
          IgnorePointer(
            child: Container(
              height: 72.0,
              decoration: new BoxDecoration(
                gradient: new LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 1.0],
                  colors: [
                    new Color(0xEE000000),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),
          Container(
            height: 72.0,
            child: new TitleBar(player),
          ),
        ],
      ),
    );
  }
}
