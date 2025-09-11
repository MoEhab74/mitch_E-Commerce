// product_item.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_state.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.icon,
    this.onTap,
  });
  final ProductModel product;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      // clipBehavior : Clip.antiAlias ===> to make the image rounded with the card
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image.network(
              widget.product.images[0],
              width: double.infinity,
              height: 150,
              fit: BoxFit.fill,
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        widget.product.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    BlocBuilder<CartCubit, CartState>(
                      builder: (context, state) {
                        return IconButton(
                          padding: EdgeInsets.zero,
                          constraints: const BoxConstraints(),
                          icon: Icon(
                            Icons.favorite,
                            color: widget.product.isFavorite
                                ? Colors.red
                                : Colors.grey,
                          ),
                          iconSize: 28,
                          onPressed: () {
                            // Add to favorites logic ===> trigger the method from the cubit
                            context.read<CartCubit>().toggleFavorite(
                              widget.product,
                            );
                          },
                        );
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$ ${widget.product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                      icon: Icon(widget.icon, size: 28),
                      onPressed: widget.onTap,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
