import 'package:chatshow/themes/dark_mode.dart';
import 'package:chatshow/themes/light_mode.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeData _themeData = lightMode;

  ThemeData get themeData => _themeData;

  bool get isDarkMode => _themeData == darkMode;

  void setThemeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  void toggleTheme() {
    _themeData == lightMode ? _themeData = darkMode : _themeData = lightMode;
    notifyListeners();
  }
}
