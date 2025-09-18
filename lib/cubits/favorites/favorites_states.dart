import 'package:minimal_e_commerce/models/product_model.dart';

class FavoritesStates {
    final List<ProductModel> products;
    FavoritesStates({this.products = const []});
}

final class FavoritesInitial extends FavoritesStates {
    FavoritesInitial() : super(products: []);
}

final class FavoritesUpdatedSuccessfully extends FavoritesStates {
    FavoritesUpdatedSuccessfully(List<ProductModel> products) : super(products: products);
}

