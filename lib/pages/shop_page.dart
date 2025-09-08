import 'package:flutter/material.dart';
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
            Padding(
              padding: const EdgeInsets.only(left: 16),
              child: ListTile(
                leading: Icon(
                  Icons.home,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                onTap: () {
                  // First close the drawer
                  Navigator.pop(context);
                  // Then push the home page
                  Navigator.pushNamed(context, HomePage.routeName);
                }
              ),
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
