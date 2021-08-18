import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { Loading, HasData, HasError, NoData, NoSearch }

class RestaurantDetailProvider extends ChangeNotifier {
  Restaurant? _restaurant;
  late ResultState _state;
  final String id;

  RestaurantDetailProvider({required this.id}) {
    _fetchDetail(id);
  }

  Future<void> _fetchDetail(String id) async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      var result =
          await ApiService().detail(id: id).timeout(Duration(seconds: 5));

      _restaurant = result.restaurants[0];
      if (_restaurant == null) {
        _state = ResultState.NoData;
        notifyListeners();
      } else if (_restaurant != null) {
        _state = ResultState.HasData;
        notifyListeners();
      }
    } on Exception catch (_) {
      _state = ResultState.HasError;
      notifyListeners();
    }
  }

  Restaurant get restaurant => _restaurant!;
  ResultState get state => _state;
}
