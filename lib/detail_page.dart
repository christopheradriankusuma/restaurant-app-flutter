import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/restaurant.dart';

class RestaurantDetail extends StatelessWidget {
  static const String routeName = '/detail';
  final Restaurant restaurant;

  RestaurantDetail({required this.restaurant});

  List<TableRow> _createTable(context) {
    List<TableRow> result = [];
    int flen = restaurant.menus['foods'].length;
    int dlen = restaurant.menus['drinks'].length;

    for (int i = 0; i < (flen > dlen ? flen : dlen); ++i) {
      result.add(
        TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Text(
                i < flen ? restaurant.menus['foods'][i]['name'] : '',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      color: Color(0xFF1E5162),
                    ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              child: Text(
                i < dlen ? restaurant.menus['drinks'][i]['name'] : '',
                style: Theme.of(context).textTheme.bodyText1!.copyWith(
                      fontSize: 20,
                      color: Color(0xFF1E5162),
                    ),
              ),
            ),
          ],
        ),
      );
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).backgroundColor,
        child: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: CircleAvatar(
                backgroundColor: Colors.black87,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  color: Colors.blue,
                  padding: const EdgeInsets.all(2),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              leadingWidth: 44,
              pinned: true,
              expandedHeight: 200,
              flexibleSpace: Stack(
                children: [
                  Positioned.fill(
                    child: Hero(
                      tag: restaurant.pictureId,
                      child: Image.network(
                        restaurant.pictureId,
                        fit: BoxFit.cover,
                        errorBuilder: (context, exception, stackTrace) {
                          return Image.asset(
                            'images/error.png',
                            fit: BoxFit.cover,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: SliverAppBarDelegate(
                minHeight: 120,
                maxHeight: 120,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FittedBox(
                        fit: BoxFit.contain,
                        child: Text(
                          restaurant.name,
                          style:
                              Theme.of(context).textTheme.headline3!.copyWith(
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(Icons.pin_drop),
                              Text(restaurant.city,
                                  style:
                                      Theme.of(context).textTheme.bodyText1!),
                            ],
                          ),
                          SizedBox(height: 8),
                          Row(
                            children: [
                              RatingBarIndicator(
                                rating: restaurant.rating.toDouble(),
                                itemCount: 5,
                                itemSize: 20,
                                direction: Axis.horizontal,
                                itemBuilder: (context, index) => Icon(
                                  Icons.star,
                                  color: Colors.amber,
                                ),
                              ),
                              Text(
                                '${restaurant.rating}',
                                style: Theme.of(context).textTheme.subtitle1,
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      restaurant.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Text('Menu'),
        onPressed: () {
          showModalBottomSheet(
            isScrollControlled: true,
            context: context,
            backgroundColor: Colors.transparent,
            builder: (context) {
              return Container(
                height: MediaQuery.of(context).size.height * 0.75,
                decoration: BoxDecoration(
                  color: Theme.of(context).backgroundColor,
                  borderRadius: BorderRadius.only(
                    topLeft: const Radius.circular(25.0),
                    topRight: const Radius.circular(25.0),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Text(
                        'Menu',
                        style: Theme.of(context).textTheme.headline4!.copyWith(
                              fontSize: 40,
                              color: Colors.indigo[900],
                            ),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Foods',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      fontSize: 40,
                                      color: Colors.indigo[900],
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            'Drinks',
                            style:
                                Theme.of(context).textTheme.headline4!.copyWith(
                                      fontSize: 40,
                                      color: Colors.indigo[900],
                                    ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Table(
                          // border: TableBorder.all(),
                          children: _createTable(context),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final double minHeight;
  final double maxHeight;
  final Widget child;

  SliverAppBarDelegate({
    required this.minHeight,
    required this.maxHeight,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Theme.of(context).appBarTheme.backgroundColor,
      width: double.infinity,
      height: maxHeight,
      child: child,
    );
  }

  @override
  double get maxExtent => maxHeight;

  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverAppBarDelegate oldDelegate) {
    return this.minHeight != oldDelegate.minHeight ||
        this.maxHeight != oldDelegate.maxHeight ||
        this.child != oldDelegate.child;
  }
}
