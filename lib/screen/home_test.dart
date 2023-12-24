import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:namer_app/screen/gallery.dart';
import 'package:namer_app/screen/producttest.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final user = FirebaseAuth.instance.currentUser;
  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
      bottomNavigationBar: NavigationBar(
        height: 80,
        elevation: 1,
        //selectedIndex: controller.selectedIndex.value,
        //onDestinationSelected: (index) =>
        //   controller.selectedIndex.value = index,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            label: "Home",
          ),
          NavigationDestination(
            icon: Icon(Icons.photo_album_outlined),
            label: "Gallery",
          ),
          NavigationDestination(
            icon: Icon(Icons.shopping_cart_outlined),
            label: "Cart",
          ),
          NavigationDestination(
            icon: Icon(Icons.people_alt_outlined),
            label: "Profile",
          ),
        ],
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        surfaceTintColor: Color(0xFF755DC1),
        indicatorColor: Color(0xFF755DC1),
      ),
      body: Container(),
    );
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 1.obs;
  final screens = [
    Container(
      color: Colors.amber,
    ),
    Container(
      color: Colors.blue,
    ),
    Container(
      color: Colors.green,
    ),
    Container(
      color: Colors.red,
    )
  ];
}
