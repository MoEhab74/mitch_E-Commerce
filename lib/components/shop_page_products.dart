import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/category_item.dart';
import 'package:minimal_e_commerce/components/products_builder.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/categories_cubit/categories_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_states.dart';

class ShopPageProducts extends StatefulWidget {
  const ShopPageProducts({super.key});

  @override
  State<ShopPageProducts> createState() => _ShopPageProductsState();
}

class _ShopPageProductsState extends State<ShopPageProducts> {
  int selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    // get the products first
    _loadProducts();
  }

  Future<void> _loadProducts() async {
    await context.read<ShopCubit>().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoriesCubit(),
      child: Column(
        children: [
          // Categories
          const SizedBox(height: 8),
          CategoryItems(),
          const SizedBox(height: 8),

          Expanded(
            child: BlocBuilder<ShopCubit, ShopState>(
              builder: (context, state) {
                if (state is ShopLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is ShopSuccess) {
                  if (state.products.isEmpty) {
                    final shopCubit = context.read<ShopCubit>();
                    if (shopCubit.lastQuery?.isNotEmpty ?? false) {
                      return const Center(
                        child: Text(
                          "No products found",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      );
                    } else {
                      return const Center(
                        child: Text(
                          "No products available",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
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
                  return Center(child: Text("Error: ${state.message}"));
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
