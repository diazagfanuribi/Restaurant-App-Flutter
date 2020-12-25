import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/error_handling.dart';
import 'package:restaurant_app/widgets/list_tile_restaurant.dart';

class ListRestaurant extends StatelessWidget {
  static const routeName = '/list_restaurant';

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.result.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.result.restaurants[index];
              return ListTileRestaurant(restaurant: restaurant);
            },
          );
        } else if (state.state == ResultState.NoData) {
          return Center(child: Text(state.message));
        } else if (state.state == ResultState.Error) {
          return Center(child: Text(state.message));
        } else {
          return Center(child: Text(''));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: FutureBuilder(
          future: Provider.of<RestaurantProvider>(context, listen: false)
              .fetchAllRestaurant(),
          builder: (context, snapshot) {
            var state = snapshot.connectionState;
            if (state == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else {
              return Consumer<RestaurantProvider>(builder: (context, state, _) {
                if (state.state == ResultState.HasData) {
                  return _buildList();
                } else if (state.state == ResultState.NoData) {
                  return ErrorHandling(
                      state.message, "assets/images/search_meal.png");
                } else if (state.state == ResultState.Error) {
                  return ErrorHandling(
                      state.message, "assets/images/search_meal.png");
                } else {
                  return ErrorHandling('', "assets/images/search_meal.png");
                }
              });
            }
          },
        ));
  }
}
