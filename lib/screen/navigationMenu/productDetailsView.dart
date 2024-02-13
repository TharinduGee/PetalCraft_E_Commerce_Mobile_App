import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/product.dart';
import 'package:namer_app/screen/navigationMenu/home.dart';
import 'package:namer_app/screen/navigationMenu/product_list.dart';
import 'package:namer_app/services/cart_service.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    String uId = FirebaseAuth.instance.currentUser!.uid.toString();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF755DC1),
        actions: [],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Positioned(
                    // top: 55,
                    child: Image.network(
                      product.productImage,
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Row(
                  children: [
                    Text(product.name!,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    SizedBox(width: 10),
                    const Icon(
                      Icons.star_rounded,
                      color: Color(0xFFFFC542),
                      size: 30,
                    ),
                    SizedBox(width: 5),
                  ],
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Text(
                      'Price : \$${product.price}',
                      style: TextStyle(fontSize: 20),
                    ),

                    // Add your other widgets here
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        product.description,
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                    ),

                    // Add your other widgets here
                  ],
                ),
              ),
              SizedBox(height: 10),
              // Add more widgets here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 30),
                    child: TextButton(
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Color.fromARGB(255, 91, 123, 196),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Row(
                              children: [
                                Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'Item added to cart',
                                  style: TextStyle(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            backgroundColor: Colors.black87,
                            duration: Duration(seconds: 3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        );
                        CartService().addItem(uId, product, 1);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
