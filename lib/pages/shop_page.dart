import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/drawer_body.dart';
import 'package:minimal_e_commerce/components/search_text_field.dart';
import 'package:minimal_e_commerce/components/shop_page_products.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';

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
        child: DrawerBody(),
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
            onPressed: () async{
              if (isSearching) {
                setState(() {
                  isSearching = false;
                });
                final shopCubit = context.read<ShopCubit>();
                if (shopCubit.lastQuery?.isNotEmpty ?? false) {
                  await shopCubit.getAllProducts();
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


