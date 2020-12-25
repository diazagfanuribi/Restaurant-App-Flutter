import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/ui/home_page.dart';
import 'package:restaurant_app/widgets/list_tile_restaurant.dart';

class SchedulerList extends StatelessWidget {
  static const routeName = '/scheduler_list';

  final List<Restaurant> restaurants;

  const SchedulerList({@required this.restaurants});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Restaurant Update'),
      ),
      body: _buildList(),
    );
  }

  Widget _buildList() {
    return ListView.builder(
      shrinkWrap: true,
      itemCount: restaurants.length,
      itemBuilder: (context, index) {
        var restaurant = restaurants[index];
        return ListTileRestaurant(restaurant: restaurant);
      },
    );
  }
}
