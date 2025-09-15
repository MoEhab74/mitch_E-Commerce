import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/categories_cubit/categories_state.dart';
import 'package:minimal_e_commerce/helper/api.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  // Gategories list
  List<String> _categories = [];
  // getAllCategories list
  Future<void> getAllCategories() async {
    try {
      emit(CategoriesLoading());
      List<dynamic> jsonData = await Api().getRequest(
        'https://dummyjson.com/products/category-list',
      );
      for (var category in jsonData) {
        _categories.add(category);
      }
      // Add all category to the list
      _categories = ['all', ..._categories];
      emit(CategoriesSuccess(_categories));
      log('Categories loaded successfully');
    } catch (e) {
      emit(CategoriesError(e.toString()));
    }
  }

  // Unmodified list of categories
  List<String> get categoriesList => List.unmodifiable(_categories);
}
