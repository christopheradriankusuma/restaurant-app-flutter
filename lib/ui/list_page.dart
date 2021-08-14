import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class ListPage extends StatelessWidget {
  static const String routeName = '/list';
  final List<Restaurant> restaurants;

  ListPage({required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dicoding Restaurant',
          style: Theme.of(context)
              .textTheme
              .headline6!
              .copyWith(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: _buildList(context),
    );
  }

  Widget _buildList(BuildContext context) {
    return ListView.builder(
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        return _buildRestaurantItem(context, restaurants[index]);
      },
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return Material(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/detail', arguments: restaurant.id);
            },
            behavior: HitTestBehavior.opaque,
            child: Container(
              color: Theme.of(context).backgroundColor,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Text(
                                  restaurant.name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(color: Colors.indigo[900]),
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
                    )
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
      ),
    );
  }
}
