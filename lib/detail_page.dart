import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:restaurant_app/restaurant.dart';

class RestaurantDetail extends StatelessWidget {
  static final String routeName = '/detail';
  final Restaurant restaurant;

  RestaurantDetail({required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
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
              child: FittedBox(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        restaurant.name,
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
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
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      restaurant.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      restaurant.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
                Container(
                  color: Theme.of(context).backgroundColor,
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text(
                      restaurant.description,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
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
