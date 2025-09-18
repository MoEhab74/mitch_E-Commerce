import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:minimal_e_commerce/cubits/cart/cart_state.dart';
import 'package:minimal_e_commerce/models/cart_item.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartCubitInitial());


  // Favorites list
  final List<ProductModel> _favorites = [];
  List<ProductModel> get favorites => List.unmodifiable(_favorites);

  // ShouldRebuildCart to determine if cart should be rebuilt
  bool get shouldRebuildCart =>
      state is CartUpdatedSuccessfully || state is FavoritesUpdatedSuccessfully;

  // List of user cart items to be displayed in the cart page ===> this will rebuild the cart page when items are added or removed
  final List<ProductModel> _cartItems = [];
  List<ProductModel> get cartItems => _cartItems;
  // List of CartModel to be stored in Hive ===> this to store the cart items in Hive only
  final List<CartModelHive> _cartItemsHive = [];
  List<CartModelHive> get getCartItemsHive => _cartItemsHive;

  // Open the cart box
  final cartBox = Hive.box<CartModelHive>('cartItems');

  // Add product to cart
  void addToCartItems(ProductModel product) async {
    // Check if product is already in _cartItemsHive or not
    if (_cartItemsHive.any((item) => item.product.id == product.id)) {
      // If it is, increase the quantity
      var existingItem = _cartItemsHive.firstWhere(
        (item) => item.product.id == product.id,
      );
      existingItem.quantity += 1;
      log('Increased quantity of ${product.title} to ${existingItem.quantity}');
      // emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
      return;
    } else {
      _cartItems.add(product);
      CartModelHive cartItem = CartModelHive(product: product, quantity: 1);
      _cartItemsHive.add(cartItem);
      log('${product.title} added to cart');
      await cartBox.put(cartItem.product.id, cartItem);
      emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
    }
  }

  // Get the Total price for all items in the cart
  double get totalPrice => _cartItemsHive.fold(
    0,
    (total, item) => total + (item.product.price * item.quantity),
  );

  // Remove product from cart
  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    _cartItemsHive.removeWhere((item) => item.product.id == product.id);
    cartBox.delete(product.id);
    log('${product.title} removed from cart');
    emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
  }

  // Clear cart
  void clearCart() {
    // check if cart is empty first
    if (_cartItems.isNotEmpty) {
      _cartItems.clear();
      _cartItemsHive.clear();
      cartBox.clear();
      log('Cart cleared');
      emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
    } else {
      log('Cart is empty');
    }
  }

  // open favorites box
  final favoriteItemsBox = Hive.box<ProductModel>('favoriteItems');
  // Add to favorites
  void toggleFavorite(ProductModel product) {
    if (_favorites.contains(product)) {
      product.isFavorite = false;
      _favorites.remove(product);
      favoriteItemsBox.delete(product.id);
      log('${product.title} removed from favorites and deleted from Hive');
    } else {
      product.isFavorite = true;
      _favorites.add(product);
      favoriteItemsBox.put(product.id, product);
      log('${product.title} added to favorites and stored in Hive');
    }
    emit(FavoritesUpdatedSuccessfully(favorites));
  }
}
