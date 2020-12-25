import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/preferences_provider.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:restaurant_app/widgets/custom_dialog.dart';
import 'package:restaurant_app/widgets/error_handling.dart';

class Profile extends StatelessWidget {
  const Profile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          title: Text('Profile'),
        ),
        body: SingleChildScrollView(
            child: Column(children: [
          SizedBox(
            height: size.height,
            child: Stack(
              children: [
                Container(
                  margin: EdgeInsets.only(top: size.height * 0.31),
                  padding: EdgeInsets.only(
                    top: size.height * 0.05,
                    left: 20,
                    right: 20,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: Consumer<PreferencesProvider>(
                      builder: (context, provider, child) {
                    return Column(
                      children: [
                        Material(
                          child: ListTile(
                            title: Text('Dark Theme'),
                            trailing: Switch.adaptive(
                                value: false,
                                onChanged: (value) => customDialog(context)),
                          ),
                        ),
                        Material(
                          child: ListTile(
                            title: Text('Daily Notification'),
                            trailing: Consumer<SchedulingProvider>(
                              builder: (context, scheduled, _) {
                                return Switch.adaptive(
                                  value: provider.isDailyNewsActive,
                                  onChanged: (value) async {
                                    if (Platform.isIOS) {
                                      customDialog(context);
                                    } else {
                                      scheduled.scheduledNews(value);
                                      provider.enableDailyNews(value);
                                    }
                                  },
                                );
                              },
                            ),
                          ),
                        )
                      ],
                    );
                  }),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 30),
                          width: 110.0,
                          height: 110.0,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: NetworkImage(
                                      "https://i.imgur.com/BoN9kdC.png")))),
                      Container(
                          padding: EdgeInsets.all(15),
                          child: Text(
                            "Your Name",
                            style: TextStyle(fontSize: 18),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
        ])));
  }
}
