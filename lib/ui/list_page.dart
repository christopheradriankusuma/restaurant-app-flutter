import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/widget/restaurant_tile.dart';

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
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: ListView.builder(
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            return RestaurantTile(restaurant: restaurants[index]);
          },
        ),
      ),
      drawer: Drawer(
        child: Container(
          color: Theme.of(context).backgroundColor,
          child: ListView(
            children: [
              ListTile(
                leading: Icon(Icons.search),
                title: Text('Search'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SearchPage.routeName);
                },
              ),
              ListTile(
                leading: Icon(
                  Icons.favorite,
                  color: Colors.red,
                ),
                title: Text('Favorite'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, FavoritePage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
