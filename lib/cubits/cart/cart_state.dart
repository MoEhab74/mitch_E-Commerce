import 'package:minimal_e_commerce/models/product_model.dart';

class CartState {
  final List<ProductModel> products;
  CartState({this.products = const []});
}

final class CartCubitInitial extends CartState {
  CartCubitInitial() : super(products: []);
}

final class CartUpdatedSuccessfully extends CartState {
  CartUpdatedSuccessfully(List<ProductModel> products) : super(products: products);
}

final class FavoritesUpdatedSuccessfully extends CartState {
  FavoritesUpdatedSuccessfully(List<ProductModel> products) : super(products: products);
}

// An Extension for CartCubitState
extension CartCubitStateX on CartState {
  // Check if the state is CartUpdatedSuccessfully or FavoritesUpdatedSuccessfully
  bool get isCartOrFavoritesUpdatedSuccessfully =>
      this is CartUpdatedSuccessfully || this is FavoritesUpdatedSuccessfully;
}
