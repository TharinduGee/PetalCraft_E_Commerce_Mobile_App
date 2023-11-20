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
      appBar: AppBar(actions: [
        IconButton(onPressed: logOut, icon: Icon(Icons.logout)),
      ]),
      body: Center(
        child: Text("Logged In"),
      ),
    );
  }
}
