import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/components/product_item.dart';
import 'package:minimal_e_commerce/models/product_model.dart';
import 'package:minimal_e_commerce/pages/products_details_view.dart';

class ProductsBuilder extends StatefulWidget {
  const ProductsBuilder({
    super.key,
    required this.products,
    required this.cubitFunction,
    this.icon,
    required this.snackBarMessage,
  });

  final List<ProductModel> products;
  final void Function(ProductModel) cubitFunction;
  final IconData? icon;
  final String snackBarMessage;
  // final ScrollController? scrollController;

  @override
  State<ProductsBuilder> createState() => _ProductsBuilderState();
}

class _ProductsBuilderState extends State<ProductsBuilder> {
  @override
  Widget build(BuildContext context) {
    if (widget.products.isEmpty) {
      return const Center(
        child: Text(
          "Cart is empty",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ),
      );
    }
    return GridView.builder(
      // controller: widget.scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        childAspectRatio: 0.75,
        crossAxisCount: 2,
      ),
      itemBuilder: (context, index) {
        final product = widget.products[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProductDetailsView(product: product),
              ),
            );
          },
          child: ProductItem(
            product: product,
            icon: widget.icon ?? Icons.add_shopping_cart,
            onTap: () {
              widget.cubitFunction(product);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${product.title} ${widget.snackBarMessage}"),
                  behavior: SnackBarBehavior.floating,
                  backgroundColor: Theme.of(context).colorScheme.onSurface,
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        );
      },
      itemCount: widget.products.length,
    );
  }
}
