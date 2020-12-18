import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/api/api_service..dart';
import 'package:restaurant_app/data/detail_restaurant.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/error_handling.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

class RestaurantDetail extends StatelessWidget {
  static const routeName = '/restaurant_detail';

  final String restaurantId;

  const RestaurantDetail({@required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Detail"),
        ),
        body: ChangeNotifierProvider<RestaurantProvider>(
          child: DetailView(
            restaurantId: restaurantId,
          ),
          create: (_) => RestaurantProvider(apiService: ApiService()),
        ));
  }
}

class DetailView extends StatelessWidget {
  final String restaurantId;

  const DetailView({@required this.restaurantId});

  @override
  Widget build(BuildContext context) {
    return _buildDetail(context);
  }

  Widget _buildDetail(BuildContext context) {
    return FutureBuilder(
      future: Provider.of<RestaurantProvider>(context, listen: false)
          .fetchDetailRestaurant(restaurantId),
      builder: (context, snapshot) {
        var state = snapshot.connectionState;
        if (state == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else {
          return Consumer<RestaurantProvider>(builder: (context, state, _) {
            if (state.state == ResultState.HasData) {
              return SingleChildScrollView(
                child: _detail(context, state.detail),
              );
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
    );
  }

  Widget _detail(BuildContext context, DetailRestaurant detailRestaurant) {
    return Column(
      children: [
        Hero(
            tag: detailRestaurant.restaurant.pictureId.split("/").last,
            child: Image.network(detailRestaurant.restaurant.pictureId)),
        Padding(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                detailRestaurant.restaurant.name,
                style: Theme.of(context).textTheme.headline6,
              ),
              Divider(color: Colors.grey),
              Text(
                detailRestaurant.restaurant.description,
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
                      rating: detailRestaurant.restaurant.rating,
                      size: 15.0,
                      isReadOnly: true,
                      color: Colors.amber,
                      borderColor: Colors.black,
                      spacing: 2),
                  Text(" ${detailRestaurant.restaurant.rating.toString()} / 5",
                      style: Theme.of(context).textTheme.bodyText1)
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
