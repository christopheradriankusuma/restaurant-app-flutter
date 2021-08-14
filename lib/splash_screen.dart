import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/ui/list_page.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/common/styles.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = '/splash';
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late List<Restaurant> restaurants;
  final ApiService _service = ApiService();

  void navigationPage() {
    Navigator.of(context)
        .pushReplacementNamed(ListPage.routeName, arguments: restaurants);
  }

  void fetchList() async {
    final res = await _service.list();
    if (res.error == false) {
      restaurants = res.restaurants;
    }
    Timer(Duration(milliseconds: 1200), navigationPage);
  }

  @override
  void initState() {
    super.initState();
    fetchList();
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
