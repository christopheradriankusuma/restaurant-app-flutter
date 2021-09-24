import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';

class RestaurantTile extends StatelessWidget {
  final Restaurant restaurant;

  RestaurantTile({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () async {
            var result = await ApiService().detail(id: restaurant.id);
            Restaurant rest = result.restaurants[0];
            Navigation.intentWithData(RestaurantDetail.routeName, rest);
          },
          behavior: HitTestBehavior.opaque,
          child: Container(
            color: Theme.of(context).backgroundColor,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Expanded(
                    flex: 1,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Hero(
                        tag: restaurant.pictureId,
                        child: Image.network(
                          "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                          width: 100,
                          fit: BoxFit.fill,
                          errorBuilder: (context, exception, stackTrace) {
                            return Image.asset(
                              'images/error.png',
                              fit: BoxFit.cover,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  restaurant.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.indigo[900]),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.location_pin,
                                size: 15.0,
                              ),
                              Text(
                                restaurant.city,
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: restaurant.rating.toDouble(),
                                itemCount: 5,
                                itemSize: 20,
                                direction: Axis.horizontal,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                              Text(
                                '${restaurant.rating}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Container(
          color: Theme.of(context).backgroundColor,
          child: Divider(
            thickness: 1,
            height: 8,
            indent: 10,
            endIndent: 10,
          ),
        ),
      ],
    );
  }
}
