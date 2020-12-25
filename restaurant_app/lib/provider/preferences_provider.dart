import 'package:flutter/material.dart';
import 'package:restaurant_app/preferences/preferences_helper.dart';

class PreferencesProvider extends ChangeNotifier {
  PreferencesHelper preferencesHelper;

  PreferencesProvider({@required this.preferencesHelper}) {
    _getDailyUpdatePreferences();
  }

  bool _isDarkTheme = false;
  bool get isDarkTheme => _isDarkTheme;

  bool _isDailyUpdateActive = false;
  bool get isDailyUpdateActive => _isDailyUpdateActive;

  void _getDailyUpdatePreferences() async {
    _isDailyUpdateActive = await preferencesHelper.isDailyUpdateActive;
    notifyListeners();
  }

  void enableDailyUpdate(bool value) {
    preferencesHelper.setDailyUpdate(value);
    _getDailyUpdatePreferences();
  }
}
