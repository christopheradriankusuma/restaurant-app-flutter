import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:flutter/foundation.dart';
import 'package:restaurant_app/utils/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;
  ResultState _state = ResultState.NoData;

  DatabaseProvider({required this.databaseHelper}) {
    getFavorites();
  }

  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _restaurants = [];
  List<Restaurant> get restaurants => _restaurants;

  void getFavorites() async {
    _restaurants = await databaseHelper.getFavorites();
    if (_restaurants.length > 0) {
      _state = ResultState.HasData;
    } else {
      _state = ResultState.NoData;
      _message = 'You have no favorites';
    }
    notifyListeners();
  }

  void updateFavorite(Restaurant restaurant) async {
    if (!restaurants.map((e) => e.pictureId).contains(restaurant.pictureId)) {
      await databaseHelper.insertFavorite(restaurant);
    } else {
      await databaseHelper.removeFavorite(restaurant.pictureId);
    }
    getFavorites();
  }
}
