import 'package:flutter/material.dart';
import 'package:restaurant_app/common/navigation.dart';

customDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text('Coming Soon!'),
        content: Text('This feature will be coming soon!'),
        actions: [
          FlatButton(
            onPressed: () {
              Navigation.back();
            },
            child: Text('Ok'),
          ),
        ],
      );
    },
  );
}
