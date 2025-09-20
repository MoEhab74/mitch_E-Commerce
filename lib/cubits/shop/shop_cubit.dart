import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:minimal_e_commerce/cubits/shop/shop_states.dart';
import 'package:minimal_e_commerce/helper/api.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class ShopCubit extends Cubit<ShopState> {
  ShopCubit() : super(ShopInitial());

  // Get all products from the API

  List<ProductModel> _shopProducts = [];

  // last query for checking if search is empty
  String? lastQuery;

  // List of filterd products by category ===> it'll be used for search
  List<ProductModel> _filteredProducts = [];

  // Search through the API

  Future<void> searchProduct(String query) async {
    emit(ShopLoading());
    try {
      // Get the products from the API
      Map<String, dynamic> jsonData = await Api().getRequest(
        'https://dummyjson.com/products/search?q=$query',
      );
      // Get the Products key from the JSON data
      List<dynamic> productsJson = jsonData['products'];
      // Convert the JSON data to ProductModel objects
      // each element in jsonData is a Map so we can model it to ProductModel
      _shopProducts = productsJson
          .map((product) => ProductModel.fromJson(product))
          .toList();
      lastQuery = query;
      emit(ShopSuccess(_shopProducts));
      log('Search from the API done successfully');
    } catch (e) {
      emit(ShopError(e.toString()));
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
      _shopProducts = productsJson
          .map((product) => ProductModel.fromJson(product))
          .toList();

      // Link the shop products to Favorites products to show the correct favorite icon state
      final favoriteBox = Hive.box<ProductModel>('favoriteItems');
      for (var product in _shopProducts) {
        if (favoriteBox.containsKey(product.id)) {
          product.isFavorite = true;
        }
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

  // Filter products by category  ===> i'll handle it from the API endpoint like getAllProducts
  Future<void> filterProductsByCategory(String category) async {
    emit(ShopLoading());
    try {
      // Get the products from the API
      Map<String, dynamic> jsonData = await Api().getRequest(
        'https://dummyjson.com/products/category/$category',
      );
      // Get the Products key from the JSON data
      List<dynamic> productsJson = jsonData['products'];
      // Convert the JSON data to ProductModel objects
      // each element in jsonData is a Map so we can model it to ProductModel
      // Clear the filteredProducts list after using it to filter the products again in the next call
      _filteredProducts = productsJson
          .map((product) => ProductModel.fromJson(product))
          .toList();

      // Link the filtered products to Favorites products to show the correct favorite icon state
      final favoriteBox = Hive.box<ProductModel>('favoriteItems');
      for (var product in _filteredProducts) {
        if (favoriteBox.containsKey(product.id)) {
          product.isFavorite = true;
        }
      }

      lastQuery = null;
      emit(ShopSuccess(_filteredProducts));
      log('Shop data fetched from the API successfully');
    } catch (e) {
      emit(ShopError(e.toString()));
    }
  }

  // Method to sync all shop products with favorites (call this when favorites change)
  void syncWithFavorites() {
    final favoriteBox = Hive.box<ProductModel>('favoriteItems');
    for (var product in _shopProducts) {
      product.isFavorite = favoriteBox.containsKey(product.id);
    }
    for (var product in _filteredProducts) {
      product.isFavorite = favoriteBox.containsKey(product.id);
    }
    
    // Re-emit the current state to trigger UI update
    if (_filteredProducts.isNotEmpty) {
      emit(ShopSuccess(_filteredProducts));
    } else if (_shopProducts.isNotEmpty) {
      emit(ShopSuccess(_shopProducts));
    }
  }
}
