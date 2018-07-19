class FrontFoodCard {
  String title;
  String description;
  String restaurant;
  String imageUrl;
  double price;

  FrontFoodCard(
      {this.title,
      this.price,
      this.restaurant,
      this.description,
      this.imageUrl});

  factory FrontFoodCard.fromJson(Map<String, dynamic> parsedJson) {
    return FrontFoodCard(
        title: parsedJson['title'],
        price: parsedJson['price'],
        restaurant: parsedJson['restaurant'],
        description: parsedJson['description'],
        imageUrl: parsedJson['imageUrl']);
  }
}
