// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:namer_app/components/catousel_slider.dart';
// import 'package:namer_app/screen/gallery.dart';
// import 'package:namer_app/screen/product_list.dart';
// import 'package:namer_app/services/CustomerService.dart';

// class Home extends StatefulWidget {
//   Home({super.key});

//   @override
//   State<Home> createState() => _HomeState();
// }

// CustomerService cusservice = CustomerService();

// String email = FirebaseAuth.instance.currentUser!.email.toString();

// void logOut() {
//   FirebaseAuth.instance.signOut();
// }

// List imgList = [
//   'vector-1',
//   'vector-1',
//   'vector-2',
// ];

// List categoryList = [
//   'Fresh Flowers',
//   'vector-1',
//   'vector-2',
// ];

// class _HomeState extends State<Home> {
//   //final user = FirebaseAuth.instance.currentUser;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView(
//         //scrollDirection: Axis.horizontal,
//         children: [
//           Container(
//               padding:
//                   EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
//               decoration: BoxDecoration(
//                   color: Color(0xFF9F7BFF),
//                   borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(10),
//                       bottomRight: Radius.circular(10))),
//               child: Column(
//                 children: [
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       IconButton(
//                           onPressed: () {
//                             Navigator.push(
//                               context,
//                               PageRouteBuilder(
//                                 pageBuilder:
//                                     (context, animation, secondaryAnimation) =>
//                                         const Gallery(),
//                                 transitionsBuilder: (context, animation,
//                                     secondaryAnimation, child) {
//                                   const begin = Offset(0.0, 1.0);
//                                   const end = Offset.zero;
//                                   var offsetAnimation =
//                                       Tween<Offset>(begin: begin, end: end)
//                                           .animate(
//                                     CurvedAnimation(
//                                       parent: animation,
//                                       curve: Curves.fastOutSlowIn,
//                                     ),
//                                   );
//                                   return SlideTransition(
//                                     position: offsetAnimation,
//                                     child: child,
//                                   );
//                                 },
//                               ),
//                             );
//                           },
//                           // onPressed: () {
//                           //   Navigator.push(
//                           //     context,
//                           //     PageRouteBuilder(
//                           //       pageBuilder:
//                           //           (context, animation, secondaryAnimation) =>
//                           //               const Gallery(),
//                           //       transitionsBuilder: (context, animation,
//                           //           secondaryAnimation, child) {
//                           //         const begin = 0.0;
//                           //         const end = 1.0;
//                           //         var opacity =
//                           //             Tween<double>(begin: begin, end: end)
//                           //                 .animate(animation);
//                           //         return FadeTransition(
//                           //           opacity: opacity,
//                           //           child: child,
//                           //         );
//                           //       },
//                           //     ),
//                           //   );
//                           // },
//                           // onPressed: () {
//                           //   Navigator.push(
//                           //     context,
//                           //     MaterialPageRoute(
//                           //         builder: (context) => const Gallery()),
//                           //   );
//                           // },
//                           icon: Icon(Icons.photo_album_rounded)),
//                       FutureBuilder<String>(
//                           future: cusservice.getUsername(email),
//                           builder: (context, snapshot) {
//                             if (snapshot.connectionState ==
//                                 ConnectionState.waiting) {
//                               return Text("Welcome !");
//                             } else if (snapshot.hasError) {
//                               return Text("Welcome !");
//                             } else {
//                               return Text(
//                                 "Welcome ${snapshot.data ?? ""} !",
//                               );
//                             }
//                           }),
//                       IconButton(onPressed: logOut, icon: Icon(Icons.logout)),
//                     ],
//                   ),
//                   SizedBox(height: 20),
//                   Padding(
//                       padding: EdgeInsets.only(left: 3, bottom: 15),
//                       child: Text(
//                         "Explore our amazing floral collection ...",
//                         style: TextStyle(
//                             fontSize: 21,
//                             fontWeight: FontWeight.w600,
//                             letterSpacing: 0.5,
//                             wordSpacing: 1,
//                             color: Colors.white),
//                       )),
//                   Container(
//                     margin: EdgeInsets.only(top: 5, bottom: 20),
//                     width: MediaQuery.of(context).size.width,
//                     height: 55,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       color: Colors.white,
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     child: TextFormField(
//                       decoration: InputDecoration(
//                           border: InputBorder.none,
//                           hintText: "Search here ...",
//                           hintStyle: TextStyle(
//                             color: Colors.black.withOpacity(0.5),
//                           ),
//                           prefixIcon: Icon(
//                             Icons.search,
//                             size: 25,
//                           )),
//                     ),
//                   ),
//                 ],
//               )),
//           Padding(
//               padding: EdgeInsets.only(top: 10, left: 15, right: 15),
//               child: SingleChildScrollView(
//                 child: Column(
//                   children: [
//                     MyCarouselSlider(),
//                   ],
//                 ),
//               )),
//           Padding(
//             padding: EdgeInsets.only(top: 20, left: 15, right: 15),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 // Padding(padding: EdgeInsets.only(top: 5,),
//                 // child:
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Text(
//                       "Categories",
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ],
//                 ),
//                 // const SizedBox(height: 20),
//                 // Categories(currentCat: "ALL"),
//                 // const SizedBox(height: 20),
//                 // const QuickAndFastList(),
//                 //),
//                 GridView.builder(
//                   //  Begins the creation of a GridView with a builder constructor, allowing for a dynamic number of children.
//                   // scrollDirection: Axis.horizontal,
//                   itemCount: imgList.length,
//                   shrinkWrap: true,

//                   physics: BouncingScrollPhysics(),
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                     crossAxisCount:
//                         2, // : Sets the number of items in each row of the grid to 2.
//                     childAspectRatio:
//                         (MediaQuery.of(context).size.height - 50 - 25) /
//                             (4 * 240),
//                     mainAxisSpacing: 10,
//                     crossAxisSpacing: 10,
//                   ),
//                   itemBuilder: (context, index) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(
//                               builder: (context) =>
//                                   ProductList(category: categoryList[index])),
//                         );
//                       },
//                       child: Container(
//                         padding:
//                             EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                         decoration: BoxDecoration(
//                           borderRadius: BorderRadius.circular(20),
//                           color: Color(0xFFF5F3FF),
//                         ),
//                         child: Column(
//                           children: [
//                             Padding(
//                               padding: EdgeInsets.all(10),
//                               child: Image.asset(
//                                 "assets/images/${imgList[index]}.png",
//                                 width: 100,
//                                 height: 100,
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               imgList[index],
//                               style: TextStyle(
//                                 fontSize: 18,
//                                 fontWeight: FontWeight.w600,
//                                 color: Colors.black.withOpacity(0.6),
//                               ),
//                             ),
//                             SizedBox(height: 10),
//                             Text(
//                               "55 videos",
//                               style: TextStyle(
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
