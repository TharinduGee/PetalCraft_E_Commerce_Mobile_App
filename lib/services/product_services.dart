import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/product.dart';

class ProductService {
  FirebaseFirestore db = FirebaseFirestore.instance;

 

  Future<Set<Product>> getProducts(String category) async {
    final productList = <Product>{};
    QuerySnapshot<Map<String, dynamic>> snapshot =
        await db.collection("Products").where("category", isEqualTo: category).get();

    if (snapshot.docs.isEmpty) {
      print("No products....");
    } else {
      for (QueryDocumentSnapshot<Map<String, dynamic>> documentSnapshot
          in snapshot.docs) {
        //Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
        productList.add(Product.fromFirestore(documentSnapshot));
      }
    }
    return productList;
  }
}
