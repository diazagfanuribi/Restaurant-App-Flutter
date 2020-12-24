import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:restaurant_app/widgets/error_handling.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

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
              return _buildRestaurantItem(context, restaurant);
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

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: restaurant.pictureId.split("/").last,
        child: Image.network(
          restaurant.pictureId,
          width: 100,
          fit: BoxFit.cover,
        ),
      ),
      title: Text(
        restaurant.name,
      ),
      subtitle: Column(
        children: [
          SizedBox(
            height: 3,
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SmoothStarRating(
                  allowHalfRating: false,
                  onRated: (v) {},
                  starCount: 5,
                  rating: restaurant.rating,
                  size: 12.0,
                  isReadOnly: true,
                  color: Colors.amber,
                  borderColor: Colors.amber[300],
                  spacing: 2),
              Text(
                " ${restaurant.rating.toString()} / 5",
                style: TextStyle(fontSize: 10),
              )
            ],
          ),
          SizedBox(
            height: 3,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Icon(
                Icons.location_pin,
                size: 10,
              ),
              Text(
                restaurant.city,
                style: TextStyle(fontSize: 11),
              )
            ],
          ),
        ],
      ),
      onTap: () {
        Navigation.intentWithData(RestaurantDetail.routeName, restaurant.id);
      },
    );
  }
}
