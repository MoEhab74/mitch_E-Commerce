// import 'package:flutter/material.dart';
// import 'package:minimal_e_commerce/components/product_item.dart';
// import 'package:minimal_e_commerce/models/product_model.dart';

// class ProductsBuilder extends StatelessWidget {
//   const ProductsBuilder({
//     super.key,
//     required this.products, required this.icon, this.onTap,
//   });

//   final List<ProductModel> products;
//   final IconData icon ;
//   final VoidCallback? onTap;

//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         mainAxisSpacing: 16,
//         crossAxisSpacing: 16,
//         childAspectRatio: 0.75,
//         crossAxisCount: 2,
//       ),
//       itemBuilder: (context, index) {
//         return ProductItem(
//           product: products[index],
//           icon: icon,
//           onTap: onTap
//         );
//       },
//       itemCount: products.length,
//     );
//   }
// }