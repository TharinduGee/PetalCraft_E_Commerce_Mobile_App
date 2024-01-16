// import 'package:flutter/material.dart';
// import 'package:namer_app/models/product.dart';
// import 'package:provider/provider.dart';

// class MyCart extends StatefulWidget {
//   const MyCart({super.key, required this.product});

//   final Product product;

//   @override
//   State<MyCart> createState() => _MyCartState();
// }

// class _MyCartState extends State<MyCart> {

//   List<String> productNames = [
//     'Flower 1',
//     'Flower 2',
//     'Flower 3',
//     'Flower 4',
//     'Flower 5',
//   ];

//   List<int> quantities = [
//     1,
//     1,
//     1,
//     1,
//     1,
//   ];

//   List<double> prices = [
//     1000.00,
//     1500.00,
//     750.00,
//     500.00,
//     2000.00,
//   ];

//   List<String> images = [
//     'assets/images/main_vector.jpg',
//     'assets/images/main_vector.jpg',
//     'assets/images/main_vector.jpg',
//     'assets/images/main_vector.jpg',
//     'assets/images/main_vector.jpg',
//   ];

//   void incrementQuantity(int index){
//     setState(() {
//       quantities[index]++;
//     });
//   }

//   void decrementQuantity(int index){
//     if(quantities[index] > 0)
//     {
//       setState(() {
//         quantities[index]--;
//     });
//     }
    
//   }

//   double getCartTotal(){
//     double total = 0.0;
//     for(int i = 0; i< productNames.length; i++){
//       total += quantities[i] * prices[i];
//     }
//     return total;
//   }

//   void showCHeckoutDialog(){
//     showDialog(
//       context: context, 
//       builder: (context){
//         return AlertDialog(
//           title: Text(
//             'Checkout'
//           ),
//           content: Text(
//             'Click Ok to purchase the product'
//           ),
//           actions: [
//             TextButton(
//               onPressed: (){

//               }, 
//               child: Text(
//                 'Ok',
//               )
//               )
//           ],
//         );
//       }
//       );
//   }

//   @override
//   Widget build(BuildContext context) {
//     List<CartItem> cartItems = Provider.of<CartProvider>(context).cartItems;
//     return Scaffold(
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.all(12.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'CART',
//                 style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
//               ),

//               Expanded(child: ListView.builder(
//                 itemCount: productNames.length,
//                 itemBuilder: ((context, index){
//                   CartItem item = cartItems[index];
//                   return Dismissible(
//                     key: Key(productNames[index]),
//                     direction: DismissDirection.endToStart,
//                     onDismissed: (direction){
//                       setState(() {
//                         productNames.removeAt(index);
//                       });
//                     },
//                     background: Container(
//                       color: Colors.red,
//                       child: Icon(Icons.cancel, color: Colors.white,),
//                       alignment: Alignment.centerRight,
//                       padding: EdgeInsets.only(right: 16.0),
//                     ),
//                     child: Container(
//                       margin: EdgeInsets.all(10.0),
//                       padding: EdgeInsets.only(right: 16.0),
//                       decoration: BoxDecoration(
//                         color: Colors.white,
//                         borderRadius: BorderRadius.circular(8),
                    
//                       ),
//                       child: Row(
//                         children: [
//                           Image.asset(
//                             images[index], 
//                             height: 50, 
//                             width: 50,
//                             ),
//                           SizedBox(width: 15.0,),
//                           Column(
//                             children: [
//                               Text(
//                                 // productNames[index],
//                                 item.name,
//                                 style: 
//                                   TextStyle(fontSize: 18.0),
                    
//                               ),
//                               Text(
//                                 // '\Rs.${prices[index].toStringAsFixed(2)}',
//                                 '\$${item.price}',
//                                 style: 
//                                 TextStyle(fontSize: 16, color: Colors.grey),)
//                             ],
//                           ),
//                           Spacer(),
//                           Row(
//                             children: [
//                               IconButton(
//                                 onPressed: (){
//                                   decrementQuantity(index);
//                                 }, 
//                                 icon: Icon(Icons.remove),
//                                 ),
//                               Text(
//                                 quantities[index].toString(),
//                                 style: TextStyle(fontSize: 18.0),
//                                 ),
//                                 IconButton(
//                                   onPressed: (){
//                                     incrementQuantity(index);
//                                   }, 
//                                   icon: Icon(Icons.add),
//                                 ),
//                             ],
//                           )
//                         ],
//                       ),
//                     ),
//                   );
//               }
//               )
//               )
//               ),
//               Divider(),
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Text(
//                       'Cart Total: ',
//                       style: TextStyle(fontSize: 18.0),
//                     ),
//                     SizedBox(width: 50.0,),
                    
//                     Text(
//                       '\Rs.${getCartTotal().toStringAsFixed(2)}',
//                       style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
//                     )
//                   ],
//                 ),
//               ),
//               Divider(),
//               Padding(
//                 padding: EdgeInsets.all(16.0),
//                 child: Row(
//                   children: [
//                     Expanded(
//                       child: ElevatedButton(
//                         onPressed: (){
//                           showCHeckoutDialog();
//                         },
//                         style: ElevatedButton.styleFrom(primary: Colors.green),
//                         child: 
//                           Text(
//                             'Proceed to Checkout',
//                           ),

//                       ),
//                     )
//                   ],
//                 ))
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }