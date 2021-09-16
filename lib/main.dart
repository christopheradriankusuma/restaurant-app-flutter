import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/styles.dart';
import 'package:restaurant_app/data/db/database_helper.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/ui/favorite_page.dart';
import 'package:restaurant_app/ui/list_page.dart';
import 'package:restaurant_app/ui/splash_screen.dart';
import 'package:restaurant_app/ui/search_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => DatabaseProvider(
            databaseHelper: DatabaseHelper(),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => SearchProvider(),
        ),
      ],
      child: MaterialApp(
        title: 'Dicoding Restaurant',
        debugShowCheckedModeBanner: false,
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
                child: ListPage(
                    restaurants: settings.arguments as List<Restaurant>),
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
          SearchPage.routeName: (context) => SearchPage(),
          FavoritePage.routeName: (context) => FavoritePage(),
        },
      ),
    );
  }
}
