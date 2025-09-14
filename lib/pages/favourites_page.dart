import 'package:animate_do/animate_do.dart';
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
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          // if (state.isCartOrFavoritesUpdatedSuccessfully) {
          final favorites = context.read<CartCubit>().favorites;

          if (favorites.isEmpty) {
            return Center(
              child: FadeIn(
                duration: const Duration(milliseconds: 600),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.heart_broken,
                      size: 100,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "No favorites yet",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w500,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: ProductsBuilder(
              products: favorites,
              cubitFunction: context.read<CartCubit>().addToCart,
              snackBarMessage: "Added to cart",
            ),
          );
          // }
        },
      ),
    );
  }
}
