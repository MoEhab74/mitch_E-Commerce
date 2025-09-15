import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/my_elevated_button.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ProductsDetailsBody extends StatelessWidget {
  const ProductsDetailsBody({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Product Image
          Container(
            height: 400,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(product.images[0]),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 16),
          // Product title
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '${product.title} : ',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          ),
          // Product description
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: SelectableText(
              product.description,
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 18,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.3,
              ),
              textAlign: TextAlign.justify,
            ),
          ),
          // Product price and rate
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Text(
                  '\$${product.price}',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
                const Spacer(),
                Row(
                  children: [
                    Row(
                      children: List.generate(
                        product.rating.toInt(),
                        (index) => const Icon(
                          Icons.star,
                          color: Colors.orange,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      product.rating.toStringAsFixed(1),
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          // Add to cart button
          MyElevatedButton(
            product: product,
            lableText: 'Add to cart',
            icon: Icons.add_shopping_cart,
            snackBarMessage: 'added to cart',
            cubitFunction: context.read<CartCubit>().addToCart,
          ),
        ],
      ),
    );
  }
}