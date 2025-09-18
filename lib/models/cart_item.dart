import 'package:hive/hive.dart';
import 'package:minimal_e_commerce/models/product_model.dart';

part 'cart_item.g.dart';

@HiveType(typeId: 1)
class CartModelHive  extends HiveObject {
  @HiveField(0)
  final ProductModel product;
  @HiveField(1)
  int quantity;
  CartModelHive({required this.product, this.quantity = 1});
}