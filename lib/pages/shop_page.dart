import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/my_list_tile.dart';
import 'package:minimal_e_commerce/components/search_text_field.dart';
import 'package:minimal_e_commerce/components/shop_page_products.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';
import 'package:minimal_e_commerce/pages/cart_page.dart';
import 'package:minimal_e_commerce/pages/favourites_page.dart';
import 'package:minimal_e_commerce/pages/home_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  static const routeName = 'ShopPage';

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  bool isSearching = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Column(
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
        ),
      ),
      appBar: AppBar(
        title: AnimatedSwitcher(
          duration: const Duration(milliseconds: 400),
          child: isSearching ? SearchTextField() : const Text('Shop Page'),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        actions: [
          IconButton(
            // Toggle the search icon
            icon: Icon(isSearching ? Icons.close : Icons.search),
            onPressed: () {
              if (isSearching) {
                setState(() {
                  isSearching = false;
                });
                final shopCubit = context.read<ShopCubit>();
                if (shopCubit.lastQuery?.isNotEmpty ?? false) {
                  shopCubit.fetchShopData();
                }
              } else {
                setState(() {
                  isSearching = true;
                });
              }
            },
          ),
        ],
      ),
      body: ShopPageProducts(),
    );
  }
}
