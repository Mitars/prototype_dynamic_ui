import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:prototype_dynamic_ui/model/food_details.dart';
import 'package:prototype_dynamic_ui/physics/custom_free_scroll_bounce.dart';
import 'package:prototype_dynamic_ui/ui/card/top_bottom_image_card.dart';

class FoodCardScroller extends StatelessWidget {
  final List<FrontFoodCard> frontFoodCards;
  final ScrollController scrollController;

  const FoodCardScroller({this.frontFoodCards, this.scrollController});

  @override
  Widget build(BuildContext context) {
    return new StaggeredGridView.countBuilder(
      crossAxisCount: 2,
      itemCount: frontFoodCards.length + 2,
      physics: new CustomFreeScrollBouncePhysics(),
      itemBuilder: (BuildContext context, int index) {
        if (index == 0 || index == frontFoodCards.length + 1) {
          return new Container(height: 62.0);
        }

        return new FoodCard(frontFoodCards[index - 1].title,
            topRightText: '${frontFoodCards[index - 1].price.toStringAsFixed(
                0)} rsd',
            topLeftText: frontFoodCards[index - 1].restaurant,
            imageUrl: frontFoodCards[index - 1].imageUrl,
            topLeftIcon: Icons.fastfood,
            description: frontFoodCards[index - 1].description);
      },
      controller: scrollController,
      staggeredTileBuilder: (index) {
        if (index == 0 || index == frontFoodCards.length + 1) {
          return new StaggeredTile.fit(2);
        }

        return new StaggeredTile.count(2, 1);
      },
    );
  }
}
