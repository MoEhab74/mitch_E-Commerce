import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/cart/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop/shop_cubit.dart';
import 'package:minimal_e_commerce/pages/cart_page.dart';
import 'package:minimal_e_commerce/pages/favourites_page.dart';
import 'package:minimal_e_commerce/pages/onboarding_page.dart';
import 'package:minimal_e_commerce/pages/shop_page.dart';
import 'package:minimal_e_commerce/theme/dark_theme.dart';
import 'package:minimal_e_commerce/theme/light_theme.dart';
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
          OnBoardingPage.routeName: (context) => OnBoardingPage(),
          ShopPage.routeName: (context) => ShopPage(),
          CartPage.routeName: (context) => CartPage(),
          FavouritesPage.routeName: (context) => FavouritesPage(),
        },
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: context.watch<ThemeProvider>().themeMode,
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce',
        home: OnBoardingPage(),
      ),
    );
  }
}
