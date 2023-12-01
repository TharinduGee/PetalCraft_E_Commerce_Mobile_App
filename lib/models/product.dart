import 'dart:ffi';

class Product {
  Product(
      {required this.productId,
      required this.productImage,
      required this.name,
      required this.price,
      required this.description});

  final String productId;
  final String productImage;
  final String name;
  final Double price;
  final String description;

  Map<String, dynamic> toMap() {
    return {
      'productId': productId,
      'productImage': productImage,
      'name': name,
      "price": price,
      "description": description
    };
  }
}
