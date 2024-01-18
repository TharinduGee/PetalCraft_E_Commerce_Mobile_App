import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/components/catousel_slider.dart';
import 'package:namer_app/screen/navigationMenu/notificationCenter.dart';
import 'package:namer_app/screen/navigationMenu/product_list.dart';
import 'package:namer_app/services/customer_service.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

final textController = TextEditingController();

class _HomeState extends State<Home> {
  void performSearch() {
    Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            ProductList(category: textController.text),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    List imgList = [
      '4',
      '6',
      '5',
    ];

    List categoryList = [
      'Fresh Flowers',
      'Flower Boquets',
      'Gifts',
    ];

    CustomerService cusservice = CustomerService();
    String uId = FirebaseAuth.instance.currentUser!.uid.toString();

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Icon(Icons.person_2)),
        title: FutureBuilder<String>(
            future: cusservice.getUsername(uId),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Text("Hello There ...");
              } else if (snapshot.hasError) {
                return Text("Welcome!");
              } else {
                return Text(
                  "Welcome ${snapshot.data ?? ""} !",
                );
              }
            }),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            child: IconButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) => NotificationPage()),
                  );
                },
                icon: Icon(Icons.notifications_active)),
          )
        ],
        scrolledUnderElevation: 1,
        backgroundColor: Color(0xFF9F7BFF),
      ),
      body: ListView(
        //scrollDirection: Axis.horizontal,
        children: [
          Container(
              padding:
                  EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
              decoration: BoxDecoration(
                  color: Color(0xFF9F7BFF),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10))),
              child: Column(
                children: [
                  Padding(
                      padding: EdgeInsets.only(left: 3, bottom: 15),
                      child: Text(
                        "Explore our amazing floral collection ...",
                        style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            wordSpacing: 1,
                            color: Colors.white),
                      )),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 20),
                    width: MediaQuery.of(context).size.width,
                    height: 55,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    // child: InkWell(
                    //   onTap: () {

                    //     // Handle the search icon click here
                    //     performSearch();
                    //   },
                    child: Row(
                      children: <Widget>[
                        SizedBox(
                          height: 50,
                          width: 50,
                          child: IconButton(
                              onPressed: () {
                                performSearch();
                              },
                              icon: Icon(Icons.search)),
                        ),
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Search here ...",
                              hintStyle: TextStyle(
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                            controller: textController,
                            validator: (String? value) {
                              if (value != null &&
                                  categoryList.contains(value)) {
                                return "Ok";
                              } else {
                                return "";
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              )),
          Padding(
              padding: EdgeInsets.only(
                top: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    MyCarouselSlider(),
                  ],
                ),
              )),
          Padding(
            padding: EdgeInsets.only(top: 5, left: 15, right: 15),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Padding(padding: EdgeInsets.only(top: 5,),
                // child:
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Text(
                      "Categories",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                GridView.builder(
                  //  Begins the creation of a GridView with a builder constructor, allowing for a dynamic number of children.
                  // scrollDirection: Axis.horizontal,
                  itemCount: imgList.length,
                  shrinkWrap: true,

                  physics: BouncingScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        2, // : Sets the number of items in each row of the grid to 2.
                    childAspectRatio:
                        (MediaQuery.of(context).size.height - 50 - 25) /
                            (4 * 240),
                    mainAxisSpacing: 10,
                    crossAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          PageRouteBuilder(
                            pageBuilder:
                                (context, animation, secondaryAnimation) =>
                                    ProductList(category: categoryList[index]),
                            transitionsBuilder: (context, animation,
                                secondaryAnimation, child) {
                              const begin = Offset(0.0, 1.0);
                              const end = Offset.zero;
                              var offsetAnimation =
                                  Tween<Offset>(begin: begin, end: end).animate(
                                CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.fastOutSlowIn,
                                ),
                              );
                              return SlideTransition(
                                position: offsetAnimation,
                                child: child,
                              );
                            },
                          ),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: Colors.black,
                            width: 2.0,
                          ),
                          color: Color.fromARGB(255, 220, 214, 252),
                        ),
                        child: Column(
                          children: [
                            Image.asset(
                              "assets/images/banners/${imgList[index]}.png",
                              width: 160,
                              height: 160,
                            ),
                            SizedBox(height: 10),
                            Text(
                              categoryList[index],
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: Colors.black.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

CustomerService cusservice = CustomerService();

String email = FirebaseAuth.instance.currentUser!.email.toString();

// void logOut(BuildContext context) {
//   FirebaseAuth.instance.signOut();
//   Navigator.pushReplacement (
//     context,
//     MaterialPageRoute(builder: (context) => LogIn),
   
//   );
//   // Navigator.pop(context);      
// }
