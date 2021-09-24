import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/search_page.dart';
import 'package:restaurant_app/ui/settings_page.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/widget/restaurant_tile.dart';

class ListPage extends StatefulWidget {
  static const String routeName = '/list';
  final List<Restaurant> restaurants;

  ListPage({required this.restaurants});

  @override
  _ListPageState createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  final NotificationHelper _notificationHelper = NotificationHelper();

  @override
  void initState() {
    super.initState();
    _notificationHelper
        .configureSelectNotificationSubject(RestaurantDetail.routeName);
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

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
          itemCount: widget.restaurants.length,
          itemBuilder: (context, index) {
            return RestaurantTile(restaurant: widget.restaurants[index]);
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
              ListTile(
                leading: Icon(Icons.settings),
                title: Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, SettingsPage.routeName);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
