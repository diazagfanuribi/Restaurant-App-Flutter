import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/search_result.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';
import 'package:restaurant_app/widgets/error_handling.dart';
import 'package:smooth_star_rating/smooth_star_rating.dart';

import 'detail_restaurant.dart';

class SearchRestaurant extends StatefulWidget {
  const SearchRestaurant({Key key}) : super(key: key);

  @override
  _SearchRestaurantState createState() => _SearchRestaurantState();
}

class _SearchRestaurantState extends State<SearchRestaurant> {
  TextEditingController editingController = TextEditingController();

  void _searchText(BuildContext context, String query) async {
    setState(() {
      Provider.of<RestaurantProvider>(context, listen: false)
          .fetchSearchRestaurant(query);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: TextField(
                  onChanged: (value) {
                    _searchText(context, value);
                  },
                  controller: editingController,
                  decoration: InputDecoration(
                      labelText: "Search",
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(
                          borderRadius:
                              BorderRadius.all(Radius.circular(25.0)))),
                ),
              ),
              Expanded(child: _searchQuery())
            ],
          ),
        ));
  }

  Widget _buildList() {
    return Consumer<RestaurantProvider>(
      builder: (context, state, _) {
        if (state.state == ResultState.Loading) {
          return Center(child: CircularProgressIndicator());
        } else if (state.state == ResultState.NoData) {
          return ErrorHandling(state.message, "assets/images/search_meal.png");
        } else if (state.state == ResultState.HasData) {
          return ListView.builder(
            shrinkWrap: true,
            itemCount: state.search.restaurants.length,
            itemBuilder: (context, index) {
              var restaurant = state.search.restaurants[index];
              return _buildRestaurantItem(context, restaurant);
            },
          );
        } else if (state.state == ResultState.Error) {
          return ErrorHandling(state.message, "assets/images/search_meal.png");
        } else {
          return ErrorHandling(state.message, "assets/images/search_meal.png");
        }
      },
    );
  }

  Widget _searchQuery() {
    return editingController.text == ""
        ? Center(
            child: Column(
            children: [
              Spacer(),
              Image(
                image: AssetImage('assets/images/salad.jpg'),
                width: 200,
              ),
              Text("Belum ada Pencarian"),
              Spacer()
            ],
          ))
        : _buildList();
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
        Navigator.pushNamed(context, RestaurantDetail.routeName,
            arguments: restaurant.id);
      },
    );
  }
}
