import 'package:flutter/material.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class MyElevatedButton extends StatelessWidget {
  const MyElevatedButton({
    super.key,
    required this.product,
    required this.lableText,
    required this.icon,
    required this.snackBarMessage, required this.cubitFunction,
  });

  final ProductModel product;
  final String lableText;
  final IconData icon;
  final String snackBarMessage;
  final void Function(ProductModel) cubitFunction;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 55,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
              side: BorderSide(
                color: Theme.of(context).colorScheme.primary,
                width: 2,
              ),
            ),
            backgroundColor: Theme.of(context).colorScheme.primary,
            foregroundColor: Theme.of(context).colorScheme.onPrimary,
            elevation: 4,
          ),
          icon: Icon(
            Icons.add_shopping_cart,
            size: 30,
            color: Theme.of(context).colorScheme.surface,
          ),
          label: Text(
            lableText,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: Theme.of(context).colorScheme.surface,
            ),
          ),
          onPressed: () {
            cubitFunction(product);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("${product.title} $snackBarMessage"),
                behavior: SnackBarBehavior.floating,
                backgroundColor: Theme.of(context).colorScheme.onSurface,
                duration: const Duration(seconds: 1),
              ),
            );
          },
        ),
      ),
    );
  }
}
