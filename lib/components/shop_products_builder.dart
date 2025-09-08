import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/product_item.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_states.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ShopProductsBuilder extends StatefulWidget {
  const ShopProductsBuilder({super.key});

  @override
  State<ShopProductsBuilder> createState() => _ShopProductsBuilderState();
}

class _ShopProductsBuilderState extends State<ShopProductsBuilder> {
  List<ProductModel> products = [];
  @override
  void initState() {
    super.initState();
    products= context.read<ShopCubit>().shopProducts;
  }

  @override
  Widget build(BuildContext context) {
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
          return ProductItem(product: products[index]);
        },
        itemCount: products.length,
      ),
    );
  }
}
