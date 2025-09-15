import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/components/fav_icon_builder.dart';
import 'package:minimal_e_commerce/components/products_details_body.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});
  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product Details'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.secondary,
        actions: [FavoriteIconBuilder(product: product)],
      ),
      body: ProductsDetailsBody(product: product),
    );
  }
}



