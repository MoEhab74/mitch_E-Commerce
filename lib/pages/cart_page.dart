import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/components/products_builder.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_state.dart';
import 'package:minimal_e_commerce/helper/empty_state_message.dart';
import 'package:minimal_e_commerce/helper/show_hint_dialog.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});
  static const routeName = 'CartPage';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Clear the cart
          // Show hint dialog first
          // check if cart is empty
          if (context.read<CartCubit>().cartItems.isEmpty) {
            showHintDialog(
              context,
              title: "Cart is empty",
              content: "Your cart is empty",
              buttonText: "OK",
            );
          } else {
            showHintDialog(
              context,
              title: "Clear Cart",
              content: "Are you sure you want to clear the cart?",
              buttonText: "Clear",
              onPressedAction: () => context.read<CartCubit>().clearCart(),
            );
          }
        },
        child: const Icon(Icons.delete_sweep_outlined, size: 32),
      ),
      body: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          // final cartCubit = context.read<CartCubit>();  ===> // Solution without Extension on CartState
          if (state.isCartOrFavoritesUpdatedSuccessfully) {
            final products = context.read<CartCubit>().cartItems;
            if (products.isEmpty) {
              return const EmptyStateMessage(
                message: "Your cart is empty",
                icon: Icons.shopping_cart_outlined,
              );
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: ProductsBuilder(
                products: products,
                cubitFunction: context.read<CartCubit>().removeFromCart,
                icon: Icons.remove_shopping_cart,
                snackBarMessage: "removed from cart",
              ),
            );
          }
          if (state is CartCubitInitial) {
            return const EmptyStateMessage(
              message: "Your cart is empty",
              icon: Icons.shopping_cart_outlined,
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}

