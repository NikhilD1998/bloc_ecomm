import 'package:equatable/equatable.dart';

class ProductModel extends Equatable {
  final String id;
  final String title;
  final double price;
  final String imageUrl;
  final double rating;
  final bool inStock;

  const ProductModel({
    required this.id,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.inStock,
  });

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
      id: map['id'] as String,
      title: map['title'] as String,
      price: (map['price'] as num).toDouble(),
      imageUrl: map['imageUrl'] as String,
      rating: (map['rating'] as num).toDouble(),
      inStock: map['inStock'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'imageUrl': imageUrl,
      'rating': rating,
      'inStock': inStock,
    };
  }

  @override
  List<Object?> get props => [id, title, price, imageUrl, rating, inStock];
}
