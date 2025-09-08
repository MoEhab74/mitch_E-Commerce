import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/product_item.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_states.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ShopProductsBuilder extends StatelessWidget {
  const ShopProductsBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopCubit, ShopState>(
      builder: (context, state) {
        // Get the products list from the cubit first
        List<ProductModel> products = context.read<ShopCubit>().fetchShopData();
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
              crossAxisCount: 2,
            ),
            itemBuilder: (context, index) {
              return ProductItem(product: products[index],);
            },
            itemCount: products.length,
          ),
        );
      },
    );
  }
}
