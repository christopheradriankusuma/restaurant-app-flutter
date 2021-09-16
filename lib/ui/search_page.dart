import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/search_provider.dart';
import 'package:restaurant_app/ui/detail_page.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widget/restaurant_tile.dart';

class SearchPage extends StatelessWidget {
  static const String routeName = '/search';

  @override
  Widget build(BuildContext context) {
    return Consumer<SearchProvider>(
      builder: (context, snapshot, _) {
        return Scaffold(
          body: Container(
            color: Theme.of(context).backgroundColor,
            child: CustomScrollView(
              slivers: [
                SliverAppBar(
                  leading: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back),
                      color: Colors.black,
                      padding: const EdgeInsets.all(2),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  pinned: true,
                  toolbarHeight: 56,
                  expandedHeight: 56,
                  title: Text('Search'),
                  leadingWidth: 44,
                ),
                SliverPersistentHeader(
                  pinned: true,
                  delegate: SliverAppBarDelegate(
                    minHeight: 100,
                    maxHeight: 100,
                    child: Container(
                      color: Theme.of(context).backgroundColor,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            TextField(
                              controller: snapshot.controller,
                              decoration: InputDecoration(
                                hintText: 'Restaurant/Menu/Category',
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ),
                                fillColor: Theme.of(context).primaryColor,
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(40),
                                ),
                              ),
                              onChanged: (text) {
                                snapshot.update(text);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      var state = snapshot.state;

                      if (state == ResultState.Loading) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Container(
                                height: 60,
                                width: 60,
                                child: CircularProgressIndicator(),
                              ),
                            ],
                          ),
                        );
                      } else if (state == ResultState.HasData) {
                        return RestaurantTile(
                            restaurant: snapshot.restaurants[index]);
                      } else if (state == ResultState.NoSearch) {
                        return Column(
                          children: [
                            SizedBox(height: 100),
                            Icon(
                              Icons.search_rounded,
                              size: 200,
                              color: Colors.grey[300],
                            ),
                          ],
                        );
                      } else if (state == ResultState.NoData) {
                        return Image.asset('images/error.png');
                      } else if (state == ResultState.HasError) {
                        return Center(
                          child: Text(
                            'Try checking your internet connection',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 16, color: Colors.redAccent),
                          ),
                        );
                      }
                    },
                    childCount: [
                      ResultState.Loading,
                      ResultState.NoData,
                      ResultState.NoSearch,
                      ResultState.HasError,
                    ].contains(snapshot.state)
                        ? 1
                        : snapshot.restaurants.length,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
