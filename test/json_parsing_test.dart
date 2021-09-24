import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

void main() {
  test('should contains at least 1 restaurant', () async {
    ApiService apiService = ApiService();
    RestaurantsResult restaurantResult = await apiService.list();
    bool result = restaurantResult.restaurants.length > 0;
    expect(result, true);
  });
}
