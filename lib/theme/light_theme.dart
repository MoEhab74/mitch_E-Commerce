import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,               
    primary: Colors.grey.shade600,                
    onPrimary: Colors.black45,             
    inversePrimary: Colors.grey.shade500, 

    secondary: Colors.black,             
    onSecondary: Colors.white60,          

    brightness: Brightness.light,     
  ),
);
