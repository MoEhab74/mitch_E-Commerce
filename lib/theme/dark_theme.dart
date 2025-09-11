import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
  colorScheme: ColorScheme.dark(
    surface: Colors.grey.shade900,
    primary: Colors.grey.shade700,
    onPrimary: Colors.white70,
    inversePrimary: Colors.grey.shade400,

    secondary: Colors.white,
    onSecondary: Colors.black54,

    brightness: Brightness.dark,
  ),
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey.shade900,
    foregroundColor: Colors.white70,
    elevation: 0,
    iconTheme: IconThemeData(color: Colors.white70),
  ),
  cardTheme: CardThemeData(
    color: Colors.grey.shade800,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
  ),
);
