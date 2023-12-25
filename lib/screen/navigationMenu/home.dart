import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/components/catousel_slider.dart';
import 'package:namer_app/screen/home.dart';
import 'package:namer_app/screen/navigationMenu/gallery.dart';
import 'package:namer_app/screen/product_list.dart';
import 'package:namer_app/services/CustomerService.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    CustomerService cusservice = CustomerService();

    String email = FirebaseAuth.instance.currentUser!.email.toString();

    void logOut() {
      FirebaseAuth.instance.signOut();
    }

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

    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 0),
          child: Image.asset(
            "assets/images/logo.png",
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(
              right: 15,
            ),
            child: Icon(Icons.notifications_outlined),
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
                    child: TextFormField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search here ...",
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.5),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            size: 25,
                          )),
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
                // const SizedBox(height: 20),
                // Categories(currentCat: "ALL"),
                // const SizedBox(height: 20),
                // const QuickAndFastList(),
                //),
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
                          MaterialPageRoute(
                              builder: (context) =>
                                  ProductList(category: categoryList[index])),
                        );
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5, horizontal: 5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
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
                            SizedBox(height: 5),
                            Text(
                              "55 items",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w500,
                              ),
                            )
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
