import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/category_item.dart';
import 'package:minimal_e_commerce/components/products_builder.dart';
import 'package:minimal_e_commerce/cubits/cart/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/favorites/favorites_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop/shop_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop/shop_states.dart';
import 'package:minimal_e_commerce/helper/empty_state_message.dart';

class ShopPageProducts extends StatefulWidget {
  const ShopPageProducts({super.key});

  @override
  State<ShopPageProducts> createState() => _ShopPageProductsState();
}

class _ShopPageProductsState extends State<ShopPageProducts> {
  int selectedIndex = 0;
  // final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    // get the products first
    _loadProducts();
    // Simulate the pagination
  }

  Future<void> _loadProducts() async {
    await context.read<ShopCubit>().getAllProducts();
    // Make sure favorites are synced after loading products
    context.read<FavoritesCubit>().reloadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Categories
        const SizedBox(height: 8),
        CategoryItems(),
        const SizedBox(height: 8),
        Expanded(
          child: FadeInUp(
            child: BlocBuilder<ShopCubit, ShopState>(
              builder: (context, state) {
                if (state is ShopLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ShopSuccess) {
                  if (state.products.isEmpty) {
                    final shopCubit = context.read<ShopCubit>();
                    if (shopCubit.lastQuery?.isNotEmpty ?? false) {
                      // Search done but no results
                      return EmptyStateMessage(
                        message:
                            "No products found\nTry searching for something else",
                        icon: Icons.search_off,
                      );
                    } else {
                      // No products available in the store at all
                      return EmptyStateMessage(
                        message:
                            "No products available\nCheck back later for new items",
                        icon: Icons.shopping_bag_outlined,
                      );
                    }
                  }
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 8,
                    ),
                    child: ProductsBuilder(
                      products: state.products,
                      cubitFunction: context.read<CartCubit>().addToCartItems,
                      icon: Icons.add_shopping_cart,
                      snackBarMessage: "added to cart",
                    ),
                  );
                } else if (state is ShopError) {
                  return EmptyStateMessage(
                    message:
                        "Error: ${state.message.length > 50 ? '${state.message.substring(0, 50)} ....' : state.message}",
                    icon: Icons.error,
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}