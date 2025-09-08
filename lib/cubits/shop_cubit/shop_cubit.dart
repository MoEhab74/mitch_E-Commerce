import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_states.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  final List<ProductModel> _shopProducts = [
    ProductModel(title: 'Product 1', price: 10, description: 'Lorem ipsum'),
    ProductModel(title: 'Product 2', price: 20, description: 'Lorem ipsum'),
    ProductModel(title: 'Product 3', price: 30, description: 'Lorem ipsum'),
    ProductModel(title: 'Product 4', price: 40, description: 'Lorem ipsum'),
    ProductModel(title: 'Product 5', price: 50, description: 'Lorem ipsum'),
    ProductModel(title: 'Product 6', price: 60, description: 'Lorem ipsum'),
    ProductModel(title: 'Product 7', price: 70, description: 'Lorem ipsum'),
    ProductModel(title: 'Product 8', price: 80, description: 'Lorem ipsum'),
    ProductModel(title: 'Product 9', price: 90, description: 'Lorem ipsum'),
    ProductModel(title: 'Product 10', price: 100, description: 'Lorem ipsum'),
  ];
  // unmodifiable to make it read only and protect from outside changes like add or remove
  List<ProductModel> get shopProducts => List.unmodifiable(_shopProducts);
  

  // List<ProductModel> fetchShopData() {
  //   emit(ShopLoading());
  //   // await Future.delayed(const Duration(seconds: 2));
  //   emit(ShopSuccess(_shopProducts));
  //   return _shopProducts;
  // }
}
