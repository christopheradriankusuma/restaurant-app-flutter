import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

enum ResultState { Loading, HasData, HasError, NoData, NoSearch }

class SearchProvider extends ChangeNotifier {
  List<Restaurant> _restaurants = [];
  ResultState _state = ResultState.NoSearch;
  final TextEditingController _controller = TextEditingController();

  Future<void> _search() async {
    if (_controller.text.length == 0) {
      _state = ResultState.NoSearch;
      notifyListeners();
      return;
    }

    try {
      _state = ResultState.Loading;
      notifyListeners();
      var result = await ApiService()
          .search(query: _controller.text)
          .timeout(Duration(seconds: 5));

      _restaurants = result.restaurants;
      if (_restaurants.length == 0) {
        _state = ResultState.NoData;
        notifyListeners();
      } else {
        _state = ResultState.HasData;
        notifyListeners();
      }
    } on Exception catch (_) {
      _state = ResultState.HasError;
      notifyListeners();
    }
  }

  void update(String text) async {
    await _search();
  }

  List<Restaurant> get restaurants => _restaurants;
  ResultState get state => _state;
  TextEditingController get controller => _controller;
}
