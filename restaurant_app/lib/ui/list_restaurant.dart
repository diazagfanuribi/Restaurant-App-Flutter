import 'package:flutter/material.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListRestaurant extends StatelessWidget {
  static const routeName = '/list_restaurant';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Restaurant App"),
      ),
      body: FutureBuilder<String>(
        future: DefaultAssetBundle.of(context)
            .loadString("assets/local_restaurant.json"),
        builder: (context, snapshot) {
          final List<Restaurant> restaurants = resultFromJson(snapshot.data);
          if (restaurants.length == null) {
            print("object");
            return Text("Loading");
          } else {
            return ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  return _buildRestaurantItem(context, restaurants[index]);
                });
          }
        },
      ),
    );
  }

  Widget _buildRestaurantItem(BuildContext context, Restaurant restaurant) {
    return ListTile(
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      leading: Hero(
        tag: restaurant.pictureId,
        child: Image.network(
          restaurant.pictureId,
          width: 100,
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
        Navigator.pushNamed(context, RestaurantDetail.routeName,
            arguments: restaurant);
      },
    );
  }
}
