import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatelessWidget {
  Home({super.key});

  final user = FirebaseAuth.instance.currentUser;
  void logOut() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer :  Drawer(),
      appBar: AppBar(
        title: Icon(Icons.home_filled),
        centerTitle:  true,
        actions: [
        IconButton(onPressed: logOut, icon: Icon(Icons.logout)), 
         //IconButton(onPressed: logOut, icon: Icon(Icons.verified_user_sharp)),
        
      ]),
      body: Center(
        child: Text("Logged In"),
      ),
    );
  }
}
