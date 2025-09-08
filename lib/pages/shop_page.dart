import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/components/my_list_tile.dart';
import 'package:minimal_e_commerce/pages/home_page.dart';

class ShopPage extends StatelessWidget {
  const ShopPage({super.key});
  static const routeName = 'ShopPage';

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
              onTap: (){
                // Close the drawer first
                Navigator.of(context).pop();
                // Then navigate to the home page
                Navigator.of(context).pushNamed(HomePage.routeName);
              }
            ),
            MyListTile(
              icon: Icons.shopping_cart_rounded,
              title: 'Shop',
              onTap: () {
                // Close the drawer
                Navigator.of(context).pop();
              }
            )
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text('Shop'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
    );
  }
}


