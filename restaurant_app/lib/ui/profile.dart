import 'package:flutter/material.dart';
import 'package:restaurant_app/widgets/error_handling.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: Center(
          child: ErrorHandling("Segera Hadir", "assets/images/search_meal.png"),
        ));
  }
}
