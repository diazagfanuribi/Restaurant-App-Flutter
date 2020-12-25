import 'dart:convert';

DetailRestaurant detailRestaurantFromJson(String str) =>
    DetailRestaurant.fromJson(json.decode(str));

String detailRestaurantToJson(DetailRestaurant data) =>
    json.encode(data.toJson());

class DetailRestaurant {
  DetailRestaurant({
    this.error,
    this.message,
    this.restaurant,
  });

  bool error;
  String message;
  Restaurant restaurant;

  factory DetailRestaurant.fromJson(Map<String, dynamic> json) =>
      DetailRestaurant(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
      };
}

class Restaurant {
  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.address,
    this.pictureId,
    this.menus,
    this.rating,
  });

  String id;
  String name;
  String description;
  String city;
  String address;
  String pictureId;
  Menus menus;
  double rating;

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: "https://restaurant-api.dicoding.dev/images/medium/" +
            json["pictureId"],
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
      );

  factory Restaurant.fromJsonDb(Map<String, dynamic> data) => Restaurant(
        id: data["id"],
        name: data["name"],
        description: data["description"],
        city: data["city"],
        address: data["address"],
        pictureId: data["pictureId"],
        rating: data["rating"].toDouble(),
        menus: Menus.fromJson(json.decode(data["menus"])),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "city": city,
        "address": address,
        "description": description,
        "pictureId": pictureId,
        "rating": rating,
        "menus": json.encode(menus.toJson()),
      };
}

class Category {
  Category({
    this.name,
  });

  String name;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
      };
}

class CustomerReview {
  CustomerReview({
    this.name,
    this.review,
    this.date,
  });

  String name;
  String review;
  String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
      };
}

class Menus {
  Menus({
    this.foods,
    this.drinks,
  });

  List<Category> foods;
  List<Category> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods:
            List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(
            json["drinks"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
      };
}
