import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_states.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  final List<ProductModel> _shopProducts = [
    ProductModel(title: 'Product A', price: 10, description: 'Lorem ipsum'),
    ProductModel(title: 'Product B', price: 20, description: 'Lorem ipsum'),
    ProductModel(title: 'Product C', price: 30, description: 'Lorem ipsum'),
    ProductModel(title: 'Product D', price: 40, description: 'Lorem ipsum'),
    ProductModel(title: 'Product E', price: 50, description: 'Lorem ipsum'),
    ProductModel(title: 'Product F', price: 60, description: 'Lorem ipsum'),
    ProductModel(title: 'Product G', price: 70, description: 'Lorem ipsum'),
    ProductModel(title: 'Product H', price: 80, description: 'Lorem ipsum'),
    ProductModel(title: 'Product I', price: 90, description: 'Lorem ipsum'),
    ProductModel(title: 'Product J', price: 100, description: 'Lorem ipsum'),
  ];
  // unmodifiable to make it read only and protect from outside changes like add or remove
  List<ProductModel> get shopProducts => List.unmodifiable(_shopProducts);

  // last query for checking if search is empty
  String? lastQuery;

  // Search about product by title

  void searchProduct(String query) {
    lastQuery = query;
    if (query.isEmpty) {
      emit(ShopSuccess(_shopProducts));
    } else {
      log('Searching for $query');
      emit(
        ShopSuccess(
          _shopProducts
              .where(
                (product) =>
                    product.title.toLowerCase().contains(query.toLowerCase()),
              )
              .toList(),
        ),
      );
    }
  }

  List<ProductModel> fetchShopData() {
    emit(ShopLoading());
    // await Future.delayed(const Duration(seconds: 2));
    lastQuery = null;
    emit(ShopSuccess(_shopProducts));
    log('Shop data fetched');
    return _shopProducts;
  }
}
