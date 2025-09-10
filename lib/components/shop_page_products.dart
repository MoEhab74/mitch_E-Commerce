import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/products_builder.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_states.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ShopPageProducts extends StatefulWidget {
  const ShopPageProducts({super.key});

  @override
  State<ShopPageProducts> createState() => _ShopPageProductsState();
}

class _ShopPageProductsState extends State<ShopPageProducts> {
  List<ProductModel> products = [];
  @override
  void initState() {
    super.initState();
    // get the products first
    products = context.read<ShopCubit>().fetchShopData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        if (state is ShopLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ShopSuccess) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: ProductsBuilder(
              products: state.products, // خدت المنتجات من state
              cubitFunction: context.read<CartCubit>().addToCart,
              icon: Icons.add_shopping_cart,
              snackBarMessage: "added to cart",
            ),
          );
        } else {
          return const Center(child: Text("No products found"));
        }
      },
    );
  }
}
