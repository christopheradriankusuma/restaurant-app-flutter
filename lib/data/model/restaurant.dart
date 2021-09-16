class RestaurantsResult {
  RestaurantsResult({
    required this.error,
    required this.message,
    required this.restaurants,
  });

  final bool error;
  final String message;
  final List<Restaurant> restaurants;

  factory RestaurantsResult.fromJson(Map<String, dynamic> json, String method) {
    if (method == "detail") {
      return RestaurantsResult(
        error: json["error"],
        message: json["message"],
        restaurants: [Restaurant.fromJson(json["restaurant"])],
      );
    } else if (method == "list") {
      return RestaurantsResult(
        error: json["error"],
        message: json["message"],
        restaurants: List<Restaurant>.from(
            (json["restaurants"] as List).map((e) => Restaurant.fromJson(e))),
      );
    } else {
      return RestaurantsResult(
        error: json["error"],
        message: json["founded"].toString(),
        restaurants: List<Restaurant>.from(
            (json["restaurants"] as List).map((e) => Restaurant.fromJson(e))),
      );
    }
  }
}

class Restaurant {
  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    required this.address,
    required this.pictureId,
    required this.categories,
    required this.menus,
    required this.rating,
    required this.customerReviews,
  });

  final String id;
  final String name;
  final String description;
  final String city;
  final String? address;
  final String pictureId;
  final List<Names>? categories;
  final Menus? menus;
  final double rating;
  final List<CustomerReview>? customerReviews;

  @override
  String toString() {
    return "Restaurant: $name";
  }

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
        id: json["id"],
        name: json["name"],
        description: json["description"] ?? "",
        city: json["city"],
        address: json["address"] ?? "",
        pictureId: json["pictureId"],
        categories: json["categories"] != null
            ? List<Names>.from(json["categories"].map((x) => Names.fromJson(x)))
            : [],
        menus: json["menus"] != null
            ? Menus.fromJson(json["menus"])
            : Menus(drinks: [], foods: []),
        rating: json["rating"].toDouble(),
        customerReviews: json["customerReviews"] != null
            ? List<CustomerReview>.from(
                json["customerReviews"].map((x) => CustomerReview.fromJson(x)))
            : [],
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
        'city': city,
        'address': address,
        'pictureId': pictureId,
        'categories': categories,
        'menus': menus,
        'rating': rating,
        'customerReviews': customerReviews,
      };
}

class Names {
  Names({
    required this.name,
  });

  final String name;

  factory Names.fromJson(Map<String, dynamic> json) => Names(
        name: json["name"],
      );
}

class CustomerReview {
  CustomerReview({
    required this.name,
    required this.review,
    required this.date,
  });

  final String name;
  final String review;
  final String date;

  factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
      );
}

class Menus {
  Menus({
    required this.foods,
    required this.drinks,
  });

  final List<Names> foods;
  final List<Names> drinks;

  factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Names>.from(json["foods"].map((x) => Names.fromJson(x))),
        drinks: List<Names>.from(json["drinks"].map((x) => Names.fromJson(x))),
      );
}
