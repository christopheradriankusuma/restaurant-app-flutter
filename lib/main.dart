import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:restaurant_app/detail_page.dart';
import 'package:restaurant_app/list_page.dart';
import 'package:restaurant_app/restaurant.dart';
import 'package:restaurant_app/splash_screen.dart';
import 'package:restaurant_app/styles.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dicoding Restaurant',
      theme: ThemeData(
        textTheme: myTextTheme,
        primaryColor: primaryColor,
        accentColor: secondaryColor,
        backgroundColor: backgroundColor,
        appBarTheme: AppBarTheme(backgroundColor: appBarColor),
      ),
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case ListPage.routeName:
            return PageTransition(
              child:
                  ListPage(restaurants: settings.arguments as List<Restaurant>),
              type: PageTransitionType.rightToLeft,
              duration: Duration(milliseconds: 750),
            );
        }
      },
      routes: {
        SplashScreen.routeName: (context) => SplashScreen(),
        RestaurantDetail.routeName: (context) => RestaurantDetail(
              restaurant:
                  ModalRoute.of(context)?.settings.arguments as Restaurant,
            ),
      },
    );
  }
}
