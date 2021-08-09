import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:restaurant_app/list_page.dart';
import 'package:restaurant_app/restaurant.dart';
import 'package:restaurant_app/styles.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late List<Restaurant> restaurants;

  void navigationPage() {
    Navigator.of(context)
        .pushReplacementNamed(ListPage.routeName, arguments: restaurants);
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/local_restaurant.json');
  }

  void readFile() async {
    final String json = await loadAsset();

    restaurants = parseRestaurant(json);

    Timer(Duration(milliseconds: 1200), navigationPage);
  }

  @override
  void initState() {
    super.initState();
    readFile();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset('images/splash.png'),
          FlutterLogo(
            size: 48,
          ),
        ],
      ),
    );
  }
}
