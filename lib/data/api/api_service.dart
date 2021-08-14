import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:restaurant_app/data/model/restaurant.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';
  // static final String _apiKey = '12345';

  Future<RestaurantsResult> list() async {
    final response = await http.get(Uri.parse(_baseUrl + "/list"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body), "list");
    } else {
      throw Exception('Failed to fetch list');
    }
  }

  Future<RestaurantsResult> detail(String id) async {
    final response = await http.get(Uri.parse(_baseUrl + "/detail/$id"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body), "detail");
    } else {
      throw Exception('Failed to fetch detail');
    }
  }

  Future<RestaurantsResult> search(String query) async {
    query = Uri.encodeComponent(query);
    final response = await http.get(Uri.parse(_baseUrl + "/search?q=$query"));
    if (response.statusCode == 200) {
      return RestaurantsResult.fromJson(json.decode(response.body), "search");
    } else {
      throw Exception('Failed to search given query');
    }
  }
}
