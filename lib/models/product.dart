import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';

class Product {
  Product({
    required this.productId,
    required this.productImage,
    required this.name,
    required this.price,
    required this.description,
  });

  final String productId;
  final String productImage;
  final String name;
  final int price;
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

  factory Product.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return Product(
      productId: data?['productId'],
      name: data?['name'],
      productImage: data?['productImage'],
      price: data?['price'],
      description: data?['description'],
    );
  }
}
