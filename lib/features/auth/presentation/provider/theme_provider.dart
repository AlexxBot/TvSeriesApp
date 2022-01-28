import 'package:flutter/material.dart';
import 'package:tvseries_app/core/global/theme_data.dart';
import 'package:tvseries_app/core/utils/store_manager.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeData = lightTheme;
  ThemeData getTheme() => _themeData;

  ThemeProvider() {
    StorageManager.readData('themeMode').then((value) {
      final themeMode = value ?? 'light';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }

  void changeMode() async {
    _themeData = _themeData == lightTheme ? darkTheme : lightTheme;
    StorageManager.saveData(
        'themeMode', _themeData == lightTheme ? 'light' : 'dark');
    notifyListeners();
  }
}
