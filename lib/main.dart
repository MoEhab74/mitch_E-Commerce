import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/pages/cart_page.dart';
import 'package:minimal_e_commerce/pages/home_page.dart';
import 'package:minimal_e_commerce/pages/shop_page.dart';
import 'package:minimal_e_commerce/theme/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        HomePage.routeName: (context) => HomePage(),
        ShopPage.routeName: (context) => ShopPage(),
        CartPage.routeName: (context) => CartPage(),
      },
      theme: lightMode,
      debugShowCheckedModeBanner: false,
      title: 'E-Commerce',
      home: HomePage(),
    );
  }
}

