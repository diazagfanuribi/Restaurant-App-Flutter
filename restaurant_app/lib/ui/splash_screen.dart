import 'dart:async';
import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();

  static const routeName = "/splash_screen";
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3),
        () => Navigator.pushReplacementNamed(context, HomePage.routeName));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            CircularProgressIndicator(
              backgroundColor: Colors.indigo,
            ),
            SizedBox(
              height: 10,
            ),
            Text("Restaurant App",
                style: Theme.of(context).textTheme.headline6),
            Spacer()
          ],
        ),
      ),
    );
  }
}
