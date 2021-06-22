class Restaurant {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final double rating;
  final Menus menus;

  Restaurant(
      {required this.id,
      required this.name,
      required this.description,
      required this.pictureId,
      required this.city,
      required this.rating,
      required this.menus});

  factory Restaurant.fromJson(Map<String, dynamic> parsedJson) => Restaurant(
        id: parsedJson["id"],
        name: parsedJson["name"],
        description: parsedJson["description"],
        pictureId: parsedJson["pictureId"],
        city: parsedJson["city"],
        rating: parsedJson["rating"],
        menus: Menus.fromJson(parsedJson["menus"]),
      );
}

class RestaurantModel {
  final List<Restaurant> listRestaurant;

  RestaurantModel({required this.listRestaurant});

  factory RestaurantModel.fromJson(Map<String, dynamic> parsedJson) =>
      RestaurantModel(
        listRestaurant: List<Restaurant>.from(
            parsedJson["restaurants"].map((x) => Restaurant.fromJson(x))),
      );
}

class Menus {
  final List<Food> foods;
  final List<Drink> drinks;

  Menus({required this.foods, required this.drinks});

  factory Menus.fromJson(Map<String, dynamic> parsedJson) => Menus(
        foods: List<Food>.from(parsedJson["foods"].map((x) => Food.fromJson(x))),
        drinks: List<Drink>.from(parsedJson["drinks"].map((x) => Drink.fromJson(x))),
      );
}

abstract class Makanan{
  final String name;

  Makanan(this.name);
}

class Food extends Makanan{
  final String name;

  Food({required this.name}) : super(name);

  factory Food.fromJson(Map<String, dynamic> parsedJson) =>
      Food(name: parsedJson['name']);
}

class Drink extends Makanan{
  final String name;

  Drink({required this.name}) : super(name);

  factory Drink.fromJson(Map<String, dynamic> parsedJson) => Drink(
        name: parsedJson["name"],
      );
}
