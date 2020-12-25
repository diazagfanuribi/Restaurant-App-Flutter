import 'package:flutter/material.dart';
import 'package:restaurant_app/ui/favorite_restaurant.dart';
import 'package:restaurant_app/ui/profile.dart';
import 'package:restaurant_app/ui/scheduler_list.dart';
import 'package:restaurant_app/ui/search_restaurant.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/notification_helper.dart';

import 'list_restaurant.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  int _bottomNavIndex = 0;

  List<Widget> _listWidget = [
    ListRestaurant(),
    SearchRestaurant(),
    FavoriteRestaurant(),
    Profile()
  ];

  List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.grey,
        ),
        label: "Home"),
    BottomNavigationBarItem(
        icon: Icon(Icons.search, color: Colors.grey), label: "Search"),
    BottomNavigationBarItem(
        icon: Icon(Icons.favorite, color: Colors.grey), label: "Favorite"),
    BottomNavigationBarItem(
        icon: Icon(Icons.person, color: Colors.grey), label: "Profile")
  ];

  void _onBottomNavTapped(int index) {
    setState(() {
      _bottomNavIndex = index;
    });
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      body: _listWidget[_bottomNavIndex],
      backgroundColor: Colors.cyan,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: _onBottomNavTapped,
        backgroundColor: Colors.grey[100],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildAndroid(context);
  }

  @override
  void initState() {
    super.initState();
    port.listen((_) async => await _service.someTask());
    _notificationHelper
        .configureSelectNotificationSubject(SchedulerList.routeName);
  }

  @override
  void dispose() {
    super.dispose();
    selectNotificationSubject.close();
  }
}
