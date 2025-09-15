import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/components/my_list_tile.dart';
import 'package:minimal_e_commerce/pages/onboarding_page.dart';
import 'package:minimal_e_commerce/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class DrawerBody extends StatelessWidget {
  const DrawerBody({super.key});

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
            Navigator.of(context).pushNamed(OnBoardingPage.routeName);
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
          // Check if the theme is dark or light first
          icon: Theme.of(context).brightness == Brightness.dark
              ? Icons.dark_mode
              : Icons.light_mode,
          // Check if the theme is dark or light first
          title:
              '${Theme.of(context).brightness == Brightness.dark ? 'Light' : 'Dark'} Mode',
          onTap: () {
            // Trigger the theme change from the ThemeProvider
            Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
          },
        ),
        // profile
        MyListTile(
          icon: Icons.person,
          title: 'Profile',
          onTap: () {
            // Close the drawer
            Navigator.of(context).pop();
            // Navigate to the profile page
          },
        ),        
      ],
    );
    // Change theme button
  }
}
