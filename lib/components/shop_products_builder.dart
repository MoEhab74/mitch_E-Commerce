import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/components/product_item.dart';

class ShopProductsBuilder extends StatelessWidget {
  const ShopProductsBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.85,
          crossAxisCount: 2,
        ),
        itemBuilder: (context, index) {
          return ProductItem();
        },
        itemCount: Colors.primaries.length,
      ),
    );
  }
}

