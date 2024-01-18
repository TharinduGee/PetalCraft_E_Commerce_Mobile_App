import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:namer_app/models/product.dart';

class CartItem {
  CartItem({
    required this.productId,
    required this.productImage,
    required this.name,
    required this.price,
    required this.description,
    required this.category,
    required this.quantity,
  });

  final int quantity;
   final String productId;
  final String productImage;
  final String name;
  final int price;
  final String description;
  final String category;

  Map<String, dynamic> toMap() {
    return {
      'quantity': quantity,
      'productId': productId,
      'productImage': productImage,
      'name': name,
      "price": price,
      "description": description,
      "category": category
    };
  }

  factory CartItem.fromMap(Map<String, dynamic> map) {
    return CartItem(
      quantity: map?['quantity'],
      productId: map?['productId'],
      name: map?['name'],
      productImage: map?['productImage'],
      price: map?['price'],
      description: map?['description'],
      category: map?['category'],
    );
  }

  factory CartItem.fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
  ) {
    final data = snapshot.data();
    return CartItem(
      quantity: data?['quantity'],
       productId: data?['productId'],
      name: data?['name'],
      productImage: data?['productImage'],
      price: data?['price'],
      description: data?['description'],
      category: data?['category'],
    );
  }
}
