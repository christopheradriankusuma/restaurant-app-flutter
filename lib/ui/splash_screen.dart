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
  bool error = false;

  void navigationPage() {
    Navigator.of(context)
        .pushReplacementNamed(ListPage.routeName, arguments: restaurants);
  }

  void fetchList() async {
    try {
      final res = await _service.list().timeout(Duration(seconds: 5));
      if (res.error == false) {
        restaurants = res.restaurants;
      }

      setState(() {
        error = false;
      });

      Timer(Duration(milliseconds: 1200), navigationPage);
    } on TimeoutException catch (_) {
      setState(() {
        error = true;
      });
      fetchList();
    }
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Expanded(
            flex: 3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('images/splash.png'),
                FlutterLogo(
                  size: 48,
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                error
                    ? Text(
                        'Something wrong, try checking your internet connection',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1!
                            .copyWith(fontSize: 16),
                        textAlign: TextAlign.center,
                      )
                    : Text(''),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
