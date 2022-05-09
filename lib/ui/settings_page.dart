import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  static const String routeName = '/settings';

  @override
  Widget build(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Settings',
              style: Theme.of(context)
                  .textTheme
                  .headline6!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
            backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          ),
          body: ListView(
            children: [
              Material(
                child: ListTile(
                  title: Text('Scheduling restaurant recommendation'),
                  trailing: Consumer<SchedulingProvider>(
                    builder: (context, scheduled, _) {
                      scheduled
                          .scheduleRestaurant(provider.isDailyRestaurantActive);
                      return Switch(
                        value: provider.isDailyRestaurantActive,
                        onChanged: (value) async {
                          scheduled.scheduleRestaurant(value);
                          provider.enableDailyRestaurant(value);
                        },
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
