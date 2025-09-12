import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/theme/dark_theme.dart';
import 'package:minimal_e_commerce/theme/light_theme.dart';

class ThemeProvider with ChangeNotifier {
  ThemeData _themeMode = lightMode;

  ThemeData get themeMode => _themeMode;

  set themeMode(ThemeData theme) {
    _themeMode = theme;
    notifyListeners();
  }

  void toggleTheme() {
    if (_themeMode == lightMode) {
      _themeMode = darkMode;
    } else {
      _themeMode = lightMode;
    }
  }
}
