import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/product_item.dart';
import 'package:minimal_e_commerce/components/products_builder.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_cubit.dart';
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
    products = context.read<ShopCubit>().shopProducts;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: ProductsBuilder(
        products: products,
        cubitFunction: context.read<CartCubit>().addToCart,
        icon: Icons.add_shopping_cart,
        snackBarMessage: "added to cart",
      ),
    );
  }
}




/*
return GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.75,
                crossAxisCount: 2,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                return ProductItem(
                  product: products[index],
                  icon: Icons.remove_shopping_cart,
                  onTap: () {
                    context.read<CartCubit>().removeFromCart(products[index]);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text("${products[index].title} removed"),
                      ),
                    );
                  },
                );
              },
            );
            // Differences
            // icon
            // onTap action
            // Cubit function
            // Snack bar message
            // 
*/