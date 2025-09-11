import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/components/my_list_tile.dart';
import 'package:minimal_e_commerce/pages/cart_page.dart';
import 'package:minimal_e_commerce/pages/favourites_page.dart';
import 'package:minimal_e_commerce/pages/home_page.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawerHeader(
          child: Icon(
            Icons.shopping_bag,
            size: 140,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(height: 32),
        MyListTile(
          icon: Icons.home,
          title: 'Home',
          onTap: () {
            // Close the drawer first
            Navigator.of(context).pop();
            // Then navigate to the home page
            Navigator.of(context).pushNamed(HomePage.routeName);
          },
        ),
        MyListTile(
          icon: Icons.shopify_sharp,
          title: 'Shop',
          onTap: () {
            // Close the drawer
            Navigator.of(context).pop();
          },
        ),
        MyListTile(
          icon: Icons.add_shopping_cart,
          title: 'Cart',
          onTap: () {
            // Close the drawer
            Navigator.of(context).pop();
            // Then navigate to the cart page
            Navigator.of(context).pushNamed(CartPage.routeName);
          },
        ),
        MyListTile(
          icon: Icons.favorite,
          title: 'Favourites',
          onTap: () {
            // Close the drawer
            Navigator.of(context).pop();
            // Then navigate to the cart page
            Navigator.of(context).pushNamed(FavouritesPage.routeName);
          },
        ),
      ],
    );
  }
}