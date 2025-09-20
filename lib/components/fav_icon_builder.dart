import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/favorites/favorites_cubit.dart';
import 'package:minimal_e_commerce/cubits/favorites/favorites_states.dart';
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
        final favoritesCubit = context.read<FavoritesCubit>();
        final isCurrentlyFavorite = favoritesCubit.isProductFavorite(product.id);
        
        return IconButton(
          padding: EdgeInsets.zero,
          constraints: const BoxConstraints(),
          icon: Icon(
            Icons.favorite,
            color: isCurrentlyFavorite
                ? Colors.red
                : Colors.grey,
          ),
          iconSize: 28,
          onPressed: () {
            // Add to favorites logic ===> trigger the method from the cubit
            context.read<FavoritesCubit>().toggleFavorite(product);
          },
        );
      },
    );
  }
}
