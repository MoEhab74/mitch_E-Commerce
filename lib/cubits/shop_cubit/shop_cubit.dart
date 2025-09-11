import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/shop_cubit/shop_states.dart';
import 'package:minimal_e_commerce/helper/api.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  // Get all products from the API

  final List<ProductModel> _shopProducts = [];

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

  // Fetch products from the API method

  Future<void> getAllProducts() async {
    emit(ShopLoading());
    // Get the products from the API
    try {
      Map<String, dynamic> jsonData = await Api().getRequest(
        'https://dummyjson.com/products',
      );
      // Get the Products key from the JSON data
      List<dynamic> productsJson = jsonData['products'];
      // Convert the JSON data to ProductModel objects
      // each element in jsonData is a Map so we can model it to ProductModel
      for (var product in productsJson) {
        // Add the products to the list
        _shopProducts.add(ProductModel.fromJson(product));
      }
      lastQuery = null;
      emit(ShopSuccess(_shopProducts));
      log('Shop data fetched from the API successfully');
    } catch (e) {
      emit(ShopError(e.toString()));
    }
    // Return the products
    // return _shopProducts;
  }

  // unmodifiable to make it read only and protect from outside changes like add or remove
  List<ProductModel> get shopProducts => List.unmodifiable(_shopProducts);

  // List<ProductModel> fetchShopData() {
  //   emit(ShopLoading());
  //   // await Future.delayed(const Duration(seconds: 2));
  //   lastQuery = null;
  //   emit(ShopSuccess(_shopProducts));
  //   log('Shop data fetched');
  //   return _shopProducts;
  // }
}
