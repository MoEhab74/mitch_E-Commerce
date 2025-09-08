import 'package:minimal_e_commerce/models/product_model.dart';

class ShopState {
  
}

class ShopInitial extends ShopState {
  
}

class ShopLoading extends ShopState {
  
}

class ShopSuccess extends ShopState {
  final List<ProductModel> products;
  ShopSuccess(this.products);
}
