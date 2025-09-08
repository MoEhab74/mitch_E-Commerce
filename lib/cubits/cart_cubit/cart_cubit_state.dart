
import 'package:minimal_e_commerce/models/product_model.dart';

class CartCubitState {}

final class CartCubitInitial extends CartCubitState {}

// final class ProductAddedSuccessfully extends CartCubitState {
//   final ProductModel product;
//   ProductAddedSuccessfully(this.product);
// }

// final class ProductRemovedSuccessfully extends CartCubitState {
//   final ProductModel product;
//   ProductRemovedSuccessfully(this.product);
// }

final class CartUpdatedSuccessfully extends CartCubitState {
  final List<ProductModel> products;
  CartUpdatedSuccessfully(this.products);
}
