import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:namer_app/screen/navigationMenu/gallery.dart';
import 'package:namer_app/screen/navigationMenu/home.dart';
import 'package:namer_app/screen/navigationMenu/profile.dart';
import 'package:namer_app/screen/producttest.dart';

class NavigationMenu extends StatelessWidget {
  NavigationMenu({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());

    return Scaffold(
        bottomNavigationBar: Obx(
          () => NavigationBar(
            height: 70,
            animationDuration: Duration(seconds: 3),
            indicatorShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30.0), bottom: Radius.circular(30.0))),
            selectedIndex: controller.selectedIndex.value,
            onDestinationSelected: (index) =>
                controller.selectedIndex.value = index,
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
            indicatorColor: Color.fromARGB(255, 167, 147, 233),
          ),
        ),
        body: Obx(() => controller.screens[controller.selectedIndex.value]));
  }
}

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  final screens = [
    Home(),
    Gallery(),
    Container(
      color: Colors.green,
    ),
    Profile()
  ];
}
