import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/cart_cubit/cart_cubit_state.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class CartCubit extends Cubit<CartCubitState> {
  CartCubit() : super(CartCubitInitial());

  // List of user cart items
  final List<ProductModel> _cartItems = [];

  List<ProductModel> get cartItems => _cartItems;

  // Favorites list
  final List<ProductModel> _favorites = [];

  // Add product to cart
  void addToCart(ProductModel product) {
    _cartItems.add(product);
    emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
  }

  // Remove product from cart
  void removeFromCart(ProductModel product) {
    _cartItems.remove(product);
    emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
  }

  // Clear cart
  void clearCart() {
    _cartItems.clear();
    emit(CartUpdatedSuccessfully(List.unmodifiable(_cartItems)));
  }

  // Add to favorites
  void addToFavorites(ProductModel product) {
    // Add product to favorites logic
    _favorites.add(product);
    emit(FavoritesUpdatedSuccessfully(List.unmodifiable(_favorites)));
  }
}
