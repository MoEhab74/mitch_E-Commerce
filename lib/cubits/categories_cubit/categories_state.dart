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

class CategoriesLoaded extends CategoriesState {
  CategoriesLoaded(List<String> categories) : super(categories: categories);
}

class CategoriesError extends CategoriesState {
  final String errorMessage;
  CategoriesError(this.errorMessage) : super(categories: []);
  
}