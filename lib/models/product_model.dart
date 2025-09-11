class ProductModel {
  final String id;
  final String title;
  final String description;
  final String category;
  final double price;
  final double rating;
  final List<String> images;
  final List<String> tags;
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

