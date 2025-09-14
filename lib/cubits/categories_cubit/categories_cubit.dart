import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:minimal_e_commerce/cubits/categories_cubit/categories_state.dart';
import 'package:minimal_e_commerce/helper/api.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  CategoriesCubit() : super(CategoriesInitial());
  // Gategories list
  final List<String> _categories = [];
  // getAllCategories list
  Future<void> getAllCategories() async {
    emit(CategoriesLoading());
    List<dynamic> jsonData = await Api().getRequest(
      'https://dummyjson.com/products/category-list',
    );
    for (var category in jsonData) {
      _categories.add(category['category']);
    }
    emit(CategoriesLoaded(_categories));
  }
  // Unmodified list of categories
  List<String> get categoriesList => List.unmodifiable(_categories);
}