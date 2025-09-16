import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/cart/cart_state.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartCubitInitial());

  // List of user cart items
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  // Favorites list
  final List<ProductModel> _favorites = [];
  List<ProductModel> get favorites => List.unmodifiable(_favorites);

  // ShouldRebuildCart to determine if cart should be rebuilt
  bool get shouldRebuildCart =>
      state is CartUpdatedSuccessfully || state is FavoritesUpdatedSuccessfully;

  // Add product to cart
  void addToCart(ProductModel product) {
    _cartItems.add(product);
    log('${product.title} added to cart');
    print(_cartItems.length);
    emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
  }

  // Remove product from cart
  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    log('${product.title} removed from cart');
    print(_cartItems.length);
    emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
  }

  // Clear cart
  void clearCart() {
    // check if cart is empty first
    if (_cartItems.isNotEmpty) {
      _cartItems.clear();
      log('Cart cleared');
      emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
    } else {
      log('Cart is empty');
    }
  }

  // Add to favorites
  void toggleFavorite(ProductModel product) {
    if (_favorites.contains(product)) {
      product.isFavorite = false;
      _favorites.remove(product);
      log('${product.title} removed from favorites');
    } else {
      product.isFavorite = true;
      _favorites.add(product);
      log('${product.title} added to favorites');
      print(favorites);
    }
    emit(FavoritesUpdatedSuccessfully(favorites));
  }
}
