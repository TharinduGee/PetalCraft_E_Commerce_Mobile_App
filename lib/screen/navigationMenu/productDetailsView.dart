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

// class ProductDetailsView extends StatelessWidget {
//   const ProductDetailsView({super.key, required this.product});

//   final Product product;

//   @override
//   Widget build(BuildContext context) {
//     String uId = FirebaseAuth.instance.currentUser!.uid.toString();

//     return Scaffold(
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Stack(
//                 children: [
//                   Container(
//                     width: double.infinity,
//                     height: 500,
//                     decoration: BoxDecoration(
//                       color: Color.fromARGB(255, 91, 123, 196),
//                       borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(30),
//                         bottomRight: Radius.circular(30),
//                       ),
//                     ),
//                   ),
//                   Positioned(
//                     top: 10,
//                     left: 10,
//                     right: 10,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         IconButton(
//                           onPressed: () {
//                             Navigator.pop(
//                               context,
//                             );
//                           },
//                           icon: Icon(Icons.backspace_outlined),
//                         ),
//                         // Add your other widgets here
//                       ],
//                     ),
//                   ),
//                   Positioned(
//                     bottom: 3000,
//                     child: Image.network(
//                       product.productImage,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(
//                 height: 20,
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: 20,
//                 ),
//                 child: Text(
//                   product.name!,
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 20),
//                 child: Row(
//                   children: [
//                     Text('\$${product.price}'),
//                     SizedBox(width: 30),
//                     const Icon(Icons.star_rounded, color: Color(0xFFFFC542)),
//                     SizedBox(width: 5),
//                     // Add your other widgets here
//                   ],
//                 ),
//               ),
//               SizedBox(height: 20),
//               // Add more widgets here
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 30),
//                 child: TextButton(
//                   child: const Text('Add to Cart'),
//                   onPressed: () {
//                     CartService().addItem(uId, product, 1);

//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }