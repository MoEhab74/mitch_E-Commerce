import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/products_builder.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_state.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});
  static const routeName = 'FavouritesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites Page'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          // if (state.isCartOrFavoritesUpdatedSuccessfully) {
            final favorites = context.read<CartCubit>().favorites;

            if (favorites.isEmpty) {
              return const Center(
                child: Text(
                  "Favourites is empty",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ProductsBuilder(
                products: favorites,
                cubitFunction: context.read<CartCubit>().toggleFavorite,
                icon: Icons.delete,
                snackBarMessage: "removed from Favorites",
              ),
            );
          // }
          // return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
