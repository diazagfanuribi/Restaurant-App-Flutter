import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/error_handling.dart';

class FavoriteRestaurant extends StatelessWidget {
  const FavoriteRestaurant({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite'),
      ),
      body: ErrorHandling("Segera Hadir", "assets/images/search_meal.png"),
    );
  }
}
