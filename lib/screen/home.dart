import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
    return Scaffold(
      drawer: Drawer(),
      appBar:
          AppBar(title: Icon(Icons.home_filled), centerTitle: true, actions: [
        IconButton(onPressed: logOut, icon: Icon(Icons.logout)),

        //IconButton(onPressed: logOut, icon: Icon(Icons.verified_user_sharp)),
      ]),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Logged In"),
            IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProductViewer()),
                  );
                },
                icon: Icon(Icons.photo_camera_back_outlined),
                iconSize: 200),
            // IconButton(
            //     onPressed: () {
            //       Navigator.push(
            //         context,
            //         MaterialPageRoute(
            //             builder: (context) => const ProfileViewer()),
            //       );
            //     },
            //     icon: Icon(Icons.person_2),
            //     iconSize: 100)
          ],
        ),
      ),
    );
  }
}
