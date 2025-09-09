
import 'package:minimal_e_commerce/models/product_model.dart';

class CartCubitState {}

final class CartCubitInitial extends CartCubitState {}

final class CartUpdatedSuccessfully extends CartCubitState {
  final List<ProductModel> products;
  CartUpdatedSuccessfully(this.products);
}

final class FavoritesUpdatedSuccessfully extends CartCubitState {
  final List<ProductModel> products;
  FavoritesUpdatedSuccessfully(this.products);
}
