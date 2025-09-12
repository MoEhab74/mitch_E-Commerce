import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';
import 'package:minimal_e_commerce/pages/cart_page.dart';
import 'package:minimal_e_commerce/pages/favourites_page.dart';
import 'package:minimal_e_commerce/pages/home_page.dart';
import 'package:minimal_e_commerce/pages/shop_page.dart';
import 'package:minimal_e_commerce/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartCubit()),
        BlocProvider(create: (context) => ShopCubit()),
      ],
      child: MaterialApp(
        routes: {
          HomePage.routeName: (context) => HomePage(),
          ShopPage.routeName: (context) => ShopPage(),
          CartPage.routeName: (context) => CartPage(),
          FavouritesPage.routeName: (context) => FavouritesPage(),
        },
        theme: Provider.of<ThemeProvider>(context).themeMode,
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce',
        home: HomePage(),
      ),
    );
  }
}
