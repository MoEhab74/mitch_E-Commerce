import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/category_item.dart';
import 'package:minimal_e_commerce/components/products_builder.dart';
import 'package:minimal_e_commerce/constants.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
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
    return Column(
      children: [
        // Categories
        const SizedBox(height: 8),
        SizedBox(
          height: 40,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedIndex = index;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Chip(
                    shape: const StadiumBorder(
                      side: BorderSide(
                        color: Colors.transparent,
                      ),
                    ),
                    backgroundColor: selectedIndex == index
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surface,
                    label: Text(categories[index]),
                    labelPadding: const EdgeInsets.symmetric(horizontal: 8),
                    labelStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: selectedIndex == index
                          ? Colors.white
                          : Theme.of(context).colorScheme.primary,
                    ),
                    side: BorderSide(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              );
            },
            separatorBuilder: (context, index) {
              return const SizedBox();
            },
            itemCount: categories.length,
          ),
        ),
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
    );
  }
}
