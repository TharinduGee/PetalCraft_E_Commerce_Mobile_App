import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/models/cartItem.dart';
import 'package:namer_app/models/product.dart';
import 'package:namer_app/services/cart_service.dart';
import 'package:namer_app/services/notification_service.dart';
import 'package:namer_app/services/order_service.dart';
import 'package:namer_app/services/product_services.dart';
import 'package:provider/provider.dart';

class MyCart extends StatefulWidget {
  const MyCart({
    super.key,
  });

  @override
  State<MyCart> createState() => _MyCartState();
}

class _MyCartState extends State<MyCart> {
  String uId = FirebaseAuth.instance.currentUser!.uid.toString();
  CartService cartService = CartService();

  void showCheckoutDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('Checkout'),
            content: Text('Click Ok to purchase the product'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Ok',
                  ))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: StreamBuilder<Set<CartItem>>(
          stream: cartService.showCartAsStream(uId),
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
                child: Text('No Products available.'),
              );
            } else {
              List<CartItem> cartItems = snapshot.data!.toList();
              double totalPrice = 0.0;

              for (CartItem cartItem in cartItems) {
                // Assuming 'price' is a field in your CartItem class
                double itemPrice = cartItem.price.toDouble() *
                    cartItem.quantity.toDouble(); // Use 0.0 if 'price' is null

                // Add the item price to the total
                totalPrice += itemPrice;
              }

              return Padding(
                padding: EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CART',
                      style:
                          TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                    ),
                    Expanded(
                        child: ListView.builder(
                            itemCount: cartItems.length,
                            itemBuilder: ((context, index) {
                              CartItem cartItem = cartItems.elementAt(index);
                              return Dismissible(
                                key: Key(cartItem.productId),
                                direction: DismissDirection.endToStart,
                                onDismissed: (direction) {
                                  cartService.deleteItem(
                                      cartItem.productId, uId);
                                },
                                background: Container(
                                  color: Colors.red,
                                  child: Icon(
                                    Icons.cancel,
                                    color: Colors.white,
                                  ),
                                  alignment: Alignment.centerRight,
                                  padding: EdgeInsets.only(right: 16.0),
                                ),
                                child: Container(
                                  margin: EdgeInsets.all(10.0),
                                  padding: EdgeInsets.only(right: 16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Row(
                                    children: [
                                      Image.network(
                                        cartItem.productImage,
                                        height: 50,
                                        width: 50,
                                      ),
                                      SizedBox(
                                        width: 15.0,
                                      ),
                                      Column(
                                        children: [
                                          Text(
                                            cartItem.name,
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                          Text(
                                            // '\Rs.${prices[index].toStringAsFixed(2)}',
                                            cartItem.price.toString(),
                                            style: TextStyle(
                                                fontSize: 16,
                                                color: Colors.grey),
                                          )
                                        ],
                                      ),
                                      Spacer(),
                                      Row(
                                        children: [
                                          IconButton(
                                            onPressed: () {
                                              CartService().decrementQuantity(
                                                  cartItem.productId, uId, -1);
                                            },
                                            icon: Icon(Icons.remove),
                                          ),
                                          Text(
                                            cartItem.quantity.toString(),
                                            style: TextStyle(fontSize: 18.0),
                                          ),
                                          IconButton(
                                            onPressed: () {
                                              CartService().decrementQuantity(
                                                  cartItem.productId, uId, 1);
                                            },
                                            icon: Icon(Icons.add),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              );
                            }))),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Row(
                        children: [
                          Text(
                            'Cart Total: ',
                            style: TextStyle(fontSize: 18.0),
                          ),
                          SizedBox(
                            width: 50.0,
                          ),
                          Text(
                            totalPrice.toString(),
                            style: TextStyle(
                                fontSize: 24.0, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    Padding(
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  showCheckoutDialog();
                                  NotificationService().publishNotification(
                                      uId, "Thank you ...", false);
                                  OrderDetailService().addDocument(
                                      uId,
                                      totalPrice,
                                      DateTime.now(),
                                      "address",
                                      DateTime.now(),
                                      true);
                                },
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.green),
                                child: Text(
                                  'Proceed to Checkout',
                                ),
                              ),
                            )
                          ],
                        ))
                  ],
                ),
              );
            }
          }),
    ));
  }
}
