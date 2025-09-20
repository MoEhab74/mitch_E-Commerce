import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:minimal_e_commerce/cubits/favorites/favorites_states.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

class FavoritesCubit extends Cubit<FavoritesStates> {
  FavoritesCubit() : super(FavoritesInitial()) {
    // Initial state

    _loadFavorites();
  }

  final favoriteItemsBox = Hive.box<ProductModel>('favoriteItems');
  
  void _loadFavorites() {
    _favorites.clear();
    _favorites.addAll(favoriteItemsBox.values);
    emit(FavoritesUpdatedSuccessfully(List.unmodifiable(_favorites)));
  }

  // Force reload favorites from Hive (useful when app starts)
  void reloadFavorites() {
    _loadFavorites();
  }

  // Favorites list
  final List<ProductModel> _favorites = [];
  List<ProductModel> get favorites => List.unmodifiable(_favorites);

  // Add to favorites
  void toggleFavorite(ProductModel product) {
    if (_favorites.any((p) => p.id == product.id)) {
      product.isFavorite = false;
      _favorites.removeWhere((p) => p.id == product.id);
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

  // Check if product is in favorites (for syncing with shop)
  bool isProductFavorite(String productId) {
    return favoriteItemsBox.containsKey(productId);
  }

  // Method to sync a product's favorite status
  void syncProductFavoriteStatus(ProductModel product) {
    product.isFavorite = isProductFavorite(product.id);
  }
}
