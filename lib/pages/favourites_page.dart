import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/products_builder.dart';
import 'package:minimal_e_commerce/cubits/cart/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/cart/cart_state.dart';
import 'package:minimal_e_commerce/helper/empty_state_message.dart';

class FavouritesPage extends StatelessWidget {
  const FavouritesPage({super.key});
  static const routeName = 'FavouritesPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          // if (state.isCartOrFavoritesUpdatedSuccessfully) {
          final favorites = context.read<CartCubit>().favorites;

          if (favorites.isEmpty) {
            return EmptyStateMessage(
              message: 'No favorites yet',
              icon: Icons.heart_broken,
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ProductsBuilder(
              products: favorites,
              cubitFunction: context.read<CartCubit>().addToCartItems,
              snackBarMessage: "Added to cart",
            ),
          );
          // }
        },
      ),
    );
  }
}
