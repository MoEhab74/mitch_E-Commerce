import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:minimal_e_commerce/cubits/auth/auth_cubit.dart';
import 'package:minimal_e_commerce/cubits/cart/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop/shop_cubit.dart';
import 'package:minimal_e_commerce/pages/cart_page.dart';
import 'package:minimal_e_commerce/pages/favourites_page.dart';
import 'package:minimal_e_commerce/pages/login_page.dart';
import 'package:minimal_e_commerce/pages/onboarding_page.dart';
import 'package:minimal_e_commerce/pages/shop_page.dart';
import 'package:minimal_e_commerce/pages/user_auth_state_page.dart';
import 'package:minimal_e_commerce/theme/dark_theme.dart';
import 'package:minimal_e_commerce/theme/light_theme.dart';
import 'package:minimal_e_commerce/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  log('Hive initialized successfully');
  // Open auth box
  var authBox = await Hive.openBox('auth');
  // log('User access token and id fetched successfully from the box');
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
        BlocProvider(create: (context) => AuthCubit()),
      ],
      child: MaterialApp(
        routes: {
          OnBoardingPage.routeName: (context) => OnBoardingPage(),
          ShopPage.routeName: (context) => ShopPage(),
          CartPage.routeName: (context) => CartPage(),
          FavouritesPage.routeName: (context) => FavouritesPage(),
          LoginPage.routeName: (context) => LoginPage(),
        },
        theme: lightMode,
        darkTheme: darkMode,
        themeMode: context.watch<ThemeProvider>().themeMode,
        debugShowCheckedModeBanner: false,
        title: 'E-Commerce',
        home: UserAuthStatePage(),
      ),
    );
  }
}
