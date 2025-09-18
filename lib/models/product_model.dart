import 'package:hive/hive.dart';
part 'product_model.g.dart';

@HiveType(typeId: 1)
class ProductModel extends HiveObject {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final String category;
  @HiveField(4)
  final double price;
  @HiveField(5)
  final double rating;
  @HiveField(6)
  final List<String> images;
  @HiveField(7) 
  final List<String> tags;
  @HiveField(8)
  bool isFavorite = false;

  ProductModel({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.price,
    required this.rating,
    required this.images,
    required this.tags,});


   factory ProductModel.fromJson(Map<String, dynamic> json) {
  return ProductModel(
    id: json['id'].toString(),
    title: json['title'],
    description: json['description'],
    category: json['category'],
    price: (json['price'] as num).toDouble(),
    rating: (json['rating'] as num).toDouble(),
    images: List<String>.from(json['images']),
    tags: List<String>.from(json['tags']),
  );
}


}

