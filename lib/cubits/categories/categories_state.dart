class CategoriesState {
  final List<String> categories;
  CategoriesState({required this.categories});
}

class CategoriesInitial extends CategoriesState {
  CategoriesInitial() : super(categories: []);
}

class CategoriesLoading extends CategoriesState {
  CategoriesLoading() : super(categories: []);
}

class CategoriesSuccess extends CategoriesState {
  CategoriesSuccess(List<String> categories) : super(categories: categories);
}

class CategoriesError extends CategoriesState {
  final String errorMessage;
  CategoriesError(this.errorMessage) : super(categories: []);
  
}