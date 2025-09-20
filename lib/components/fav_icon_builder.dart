import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/favorites/favorites_cubit.dart';
import 'package:minimal_e_commerce/cubits/favorites/favorites_states.dart';
import 'package:minimal_e_commerce/cubits/shop/shop_cubit.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class FavoriteIconBuilder extends StatelessWidget {
  const FavoriteIconBuilder({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FavoritesCubit, FavoritesStates>(
      builder: (context, state) {
        if (state is FavoritesLoading) {
          return Center(child: const CircularProgressIndicator());
        }
        else if (state is FavoritesUpdatedSuccessfully) {
          return IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            Icons.favorite,
            color: product.isFavorite
                ? Colors.red
                : Colors.grey,
          ),
          iconSize: 28,
          onPressed: () {
            // Add to favorites logic ===> trigger the method from the cubit
            context.read<FavoritesCubit>().toggleFavorite(product);
            
            // Sync with shop cubit to update the UI in shop page
            try {
              context.read<ShopCubit>().syncWithFavorites();
            } catch (e) {
              // ShopCubit might not be available in all contexts, that's ok
            }
          },
        );
        }
        return const SizedBox();
      },
    );
  }
}
