import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:restaurant_app/data/detail_restaurant.dart';
import 'package:restaurant_app/provider/database_provider.dart';
import 'package:restaurant_app/utils/result_state.dart';
import 'package:restaurant_app/widgets/error_handling.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'detail_restaurant.dart';

class FavoriteRestaurant extends StatelessWidget {
  static const routeName = '/favorite_restaurant';

  const FavoriteRestaurant({Key key}) : super(key: key);

  Widget _buildList() {
    return Consumer<DatabaseProvider>(builder: (context, provider, child) {
      if (provider.state == ResultState.HasData) {
        return ListView.builder(
          itemCount: provider.bookmarks.length,
          itemBuilder: (context, index) {
            return ListTileFavorite(
              context: context,
              restaurant: provider.bookmarks[index],
            );
          },
        );
      } else {
        return ErrorHandling("Empty Data", "assets/images/search_meal.png");
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Home'),
        ),
        body: _buildList());
  }
}

class ListTileFavorite extends StatelessWidget {
  const ListTileFavorite({
    Key key,
    @required this.context,
    @required this.restaurant,
  }) : super(key: key);

  final BuildContext context;
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Consumer<DatabaseProvider>(
      builder: (context, provider, child) {
        return FutureBuilder<bool>(
          future: provider.isBookmarked(restaurant.id),
          builder: (context, snapshot) {
            var isBookmarked = snapshot.data ?? false;
            return Dismissible(
              key: Key(restaurant.id.toString()),
              background: Container(color: Colors.indigo),
              onDismissed: (direction) {
                provider.removeBookmark(restaurant.id);
              },
              child: ListTile(
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
              ),
            );
          },
        );
      },
    );
  }
}
