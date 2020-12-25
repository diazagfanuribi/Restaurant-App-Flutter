import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PreferencesHelper {
  final Future<SharedPreferences> sharedPreferences;

  PreferencesHelper({@required this.sharedPreferences});

  static const DAILY_UPDATE = 'DAILY_UPDATE';

  Future<bool> get isDailyUpdateActive async {
    final prefs = await sharedPreferences;
    return prefs.getBool(DAILY_UPDATE) ?? false;
  }

  void setDailyUpdate(bool value) async {
    final prefs = await sharedPreferences;
    prefs.setBool(DAILY_UPDATE, value);
  }
}
