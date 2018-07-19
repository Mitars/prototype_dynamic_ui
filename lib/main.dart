import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:prototype_dynamic_ui/ui/card/top_bottom_image_card.dart';
import 'package:prototype_dynamic_ui/model/food_details.dart';
import 'package:prototype_dynamic_ui/ui/shadow.dart';
import 'package:prototype_dynamic_ui/title_bar.dart';
import 'package:audioplayers/audio_cache.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prototype_dynamic_ui/ui/custom_bounce.dart' as psy;

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
  static const double menuHeight = 76.0;
  double scrollOffset = -menuHeight;

  List<FrontFoodCard> frontFoodCards;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.bottom]);

    AudioCache player = new AudioCache();
    // TODO: stutter, does not stop music when the app goes to the background
    // player.loop('menu.mp3');

    ScrollController _scrollController =
        new ScrollController(keepScrollOffset: false);
    _scrollController.addListener(() {
      scrollOffset = _scrollController.offset - menuHeight;
      this.setState(() {});
    });

    frontFoodCards = [
      new FrontFoodCard(
          title: 'Spagete Bolonjeze',
          price: 350.0,
          restaurant: 'Extra Food',
          description: 'Spagete, Bolonjez sos (Paradajz, Luk, Mleveno Meso)',
          imageUrl:
              'https://img.taste.com.au/VFkGwzXU/w720-h480-cfill-q80/taste/2016/11/spaghetti-bolognese-106560-1.jpeg'),
      new FrontFoodCard(
          title: 'Capricoza',
          price: 350.0,
          restaurant: 'Big Pizza',
          description: 'Testo, Pecurke, Sunka',
          imageUrl: 'https://recipes.timesofindia.com/photo/53110049.cms'),
      new FrontFoodCard(
          title: 'Paradajz Corba',
          price: 120.0,
          restaurant: 'Extra Food',
          description: 'Paradajz, Zacini',
          imageUrl:
              'https://atmedia.imgix.net/c0d49cd0c7ff33b17764502ed22777d702599990?w=1500&fit=max'),
      new FrontFoodCard(
          title: 'Karadjordjeva Snicla',
          price: 290.0,
          restaurant: 'Extra Food',
          description: 'Svinsko meso',
          imageUrl:
              'https://belgrade-beat.rs/photos/articles/366/c-1515762102.jpg'),
      new FrontFoodCard(
          title: 'Burito',
          price: 253.2,
          restaurant: 'Tortilja Kasa',
          description: 'Tortilja, Pasulj, Mleveno meso, Paprika, Luk',
          imageUrl:
              'https://img.sndimg.com/food/image/upload/w_896,h_504,c_fill,fl_progressive,q_80/v1/img/recipes/60/71/4/GidRq10yRvmCa76hJBkD_burrito4.jpg'),
      new FrontFoodCard(
          title: 'Hamburger',
          price: 400.0,
          restaurant: 'Toster Bar',
          description: 'Junece meso, Krastavci, Ketchup',
          imageUrl:
              'https://www.kraftlokator.com/wp-content/uploads/2017/04/Toster-Bar-4.jpg'),
      new FrontFoodCard(
          title: 'Vocna Torta',
          price: 220.0,
          restaurant: 'Hedone',
          description: 'Jagode, Secer, Puding, Slag',
          imageUrl:
              'https://minimalistbaker.com/wp-content/uploads/2018/02/1-Bowl-Vegan-Gluten-Free-Vanilla-Cake-Egg-free-oil-free-fluffy-perfectly-sweet-SO-delicious-vegan-glutenfree-cake-recipe-plantbased-minimalistbaker-9.jpg'),
      new FrontFoodCard(
          title: 'Test Card',
          price: 999.9,
          restaurant: 'Test',
          description:
              'Test card 1.0, Value 1, Value 2, Value 3, Value 4, Value 5, Value 1, Value 2, Value 3, Value 4, Value 5',
          imageUrl:
              'https://globalfm.org/DEV/wp-content/uploads/2017/01/test.gif'),
    ];

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
                      physics: new psy.BouncingScrollPhysics(),
                      itemBuilder: (BuildContext context, int index) {
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
              height: -scrollOffset < 0.0 ? 0.0 : -scrollOffset,
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
                      opacity: (1.0 - (-scrollOffset * 0.0015) < 0.0)
                          ? (0.0)
                          : ((1.0 - (-scrollOffset * 0.0015) > 1)
                              ? (1.0)
                              : (1.0 - (-scrollOffset * 0.0015))),
                      child: Container(
                        color: new Color(0x77000000),
                      ),
                    ),
                    Align(
                      alignment: new Alignment(0.0, -0.5),
                      child: Transform(
                        transform: Matrix4.translationValues(
                            0.0, -500.0 - scrollOffset, 0.0),
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
          IgnorePointer(
            child: Align(
              alignment: new Alignment(0.0, -1.0),
              child: Container(
                height: menuHeight,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    colors: [
                      new Color(0xDD000000),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),
          ),
          IgnorePointer(
            child: Align(
              alignment: new Alignment(0.0, 1.0),
              child: Container(
                height: menuHeight,
                decoration: new BoxDecoration(
                  gradient: new LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.0, 1.0],
                    colors: [
                      Colors.transparent,
                      new Color(0xDD000000),
                    ],
                  ),
                ),
              ),
            ),
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
                0.0,
                menuHeight + scrollOffset > 0.0
                    ? 0.0
                    : -menuHeight - scrollOffset,
                0.0),
            child: Container(
              height: menuHeight,
              child: new TitleBar(player),
            ),
          ),
        ],
      ),
    );
  }
}
