import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/restaurant_tile.dart';

class FavoritePage extends StatelessWidget {
  static const String routeName = '/favorite';

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, snapshot, _) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Favorite Restaurants',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          body: Container(
            color: Theme.of(context).backgroundColor,
            child: snapshot.state == ResultState.HasData
                ? ListView.builder(
                    itemCount: snapshot.restaurants.length,
                    itemBuilder: (context, index) {
                      return RestaurantTile(
                          restaurant: snapshot.restaurants[index]);
                    },
                  )
                : Center(
                    child: Text(snapshot.message),
                  ),
          ),
        );
      },
    );
  }
}
