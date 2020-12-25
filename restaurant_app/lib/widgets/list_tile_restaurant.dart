import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/ui/detail_restaurant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class ListTileRestaurant extends StatelessWidget {
  const ListTileRestaurant({
    Key key,
    @required this.restaurant,
  }) : super(key: key);

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
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
                Navigation.intentWithData(
                    RestaurantDetail.routeName, restaurant.id);
              },
              trailing: isBookmarked
                  ? IconButton(
                      icon: Icon(Icons.bookmark),
                      onPressed: () => {},
                    )
                  : IconButton(
                      icon: Icon(Icons.bookmark_border),
                      onPressed: () => {},
                    ),
            );
          },
        );
      },
    );
  }
}
