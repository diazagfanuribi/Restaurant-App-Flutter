import 'package:flutter/material.dart';
import 'package:restaurant_app/data/restaurant.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final Restaurant restaurant;

  const RestaurantDetail({@required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News App'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: restaurant.pictureId,
                child: Image.network(restaurant.pictureId)),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    restaurant.name,
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Divider(color: Colors.grey),
                  Text(
                    restaurant.description,
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  Divider(color: Colors.grey),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SmoothStarRating(
                          allowHalfRating: false,
                          onRated: (v) {},
                          starCount: 5,
                          rating: restaurant.rating,
                          size: 15.0,
                          isReadOnly: true,
                          color: Colors.amber,
                          borderColor: Colors.black,
                          spacing: 2),
                      Text(" ${restaurant.rating.toString()} / 5",
                          style: Theme.of(context).textTheme.bodyText1)
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
