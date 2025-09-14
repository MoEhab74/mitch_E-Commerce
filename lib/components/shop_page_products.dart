import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/category_item.dart';
import 'package:minimal_e_commerce/components/products_builder.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_states.dart';
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
                      return Center(
                        child: FadeIn(
                          duration: const Duration(milliseconds: 600),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.shopping_bag_outlined,
                                size: 100,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                              const SizedBox(height: 16),
                              Text(
                                textAlign: TextAlign.center,
                                "No products available\nCheck back later for new items",
                                style: TextStyle(
                                  color: Theme.of(context).colorScheme.primary,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
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
                      cubitFunction: context.read<CartCubit>().addToCart,
                      icon: Icons.add_shopping_cart,
                      snackBarMessage: "added to cart",
                    ),
                  );
                } else if (state is ShopError) {
                  return Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.error,
                          size: 100,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Error: ${state.message.length > 50 ? {'${state.message.substring(0, 50)} ....'} : state.message}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
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
