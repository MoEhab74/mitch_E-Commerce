import 'package:minimal_e_commerce/models/product_model.dart';

class CartState {}

final class CartCubitInitial extends CartState {}

final class CartUpdatedSuccessfully extends CartState {
  final List<ProductModel> products;
  CartUpdatedSuccessfully(this.products);
}

final class FavoritesUpdatedSuccessfully extends CartState {
  final List<ProductModel> products;
  FavoritesUpdatedSuccessfully(this.products);
}

// An Extension for CartCubitState
extension CartCubitStateX on CartState {
  // Check if the state is CartUpdatedSuccessfully or FavoritesUpdatedSuccessfully
  bool get isCartOrFavoritesUpdatedSuccessfully =>
      this is CartUpdatedSuccessfully || this is FavoritesUpdatedSuccessfully;
}
