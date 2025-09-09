import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/components/product_item.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ProductsBuilder extends StatelessWidget {
  const ProductsBuilder({
    super.key,
    required this.products,
    required this.cubitFunction,
    required this.icon,
    required this.snackBarMessage,
  });

  final List<ProductModel> products;
  final void Function(ProductModel) cubitFunction;
  final IconData icon;
  final String snackBarMessage;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        return ProductItem(
          product: products[index],
          icon: icon,
          onTap: () {
            cubitFunction(products[index]);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${products[index].title} $snackBarMessage"),
              ),
            );
          },
        );
      },
      itemCount: products.length,
    );
  }
}