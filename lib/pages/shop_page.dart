import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/drawer_body.dart';
import 'package:minimal_e_commerce/components/search_text_field.dart';
import 'package:minimal_e_commerce/components/shop_page_products.dart';
import 'package:minimal_e_commerce/cubits/categories/categories_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop/shop_cubit.dart';
import 'package:minimal_e_commerce/pages/favourites_page.dart';

class ShopPage extends StatefulWidget {
  const ShopPage({super.key});
  static const routeName = 'ShopPage';

  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  int selectedIndex = 0;
  bool isSearching = false;

  int? previousIndex;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(),
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        drawer: Drawer(
          backgroundColor: Theme.of(context).colorScheme.surface,
          child: DrawerBody(),
        ),
        appBar: AppBar(
          title: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            child: isSearching ? SearchTextField() : const Text('Mitch Store'),
          ),
          centerTitle: true,
          backgroundColor: Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.secondary,
          actions: [
            IconButton(
              // Toggle the search icon
              icon: Icon(isSearching ? Icons.close : Icons.search),
              onPressed: () async {
                if (isSearching) {
                  setState(() {
                    isSearching = false;
                    if (previousIndex != null) {
                      selectedIndex = previousIndex!;
                      previousIndex = null;
                    }
                  });
                  final shopCubit = context.read<ShopCubit>();
                  if (shopCubit.lastQuery?.isNotEmpty ?? false) {
                    await shopCubit.getAllProducts();
                  }
                } else {
                  setState(() {
                    previousIndex = selectedIndex;
                    selectedIndex = 0;
                    isSearching = true;
                  });
                }
              },
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: selectedIndex,
          onTap: (index) {
            setState(() {
              selectedIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Shop'),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorites',
            ),
          ],
        ),
        body: IndexedStack(
          index: selectedIndex,
          children: [ShopPageProducts(), FavouritesPage()],
        ),
      ),
    );
  }
}
