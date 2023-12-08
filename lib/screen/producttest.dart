import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/screen/firestore_service.dart';
import 'package:namer_app/services/product_services.dart';

class ProductViewer extends StatefulWidget {
  const ProductViewer({super.key});

  @override
  State<ProductViewer> createState() => _ProductViewerState();
}

final ProductService productService = ProductService();

class _ProductViewerState extends State<ProductViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: productService.getProducts(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text('No image URLs available.'),
            );
          } else {
            return Text("added...");
          }
        },
      ),
    );
  }
}
