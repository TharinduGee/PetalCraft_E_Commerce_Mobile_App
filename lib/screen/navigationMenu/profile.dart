import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_auth/firebase_ui_auth.dart';
import 'package:flutter/material.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: SignOutButton()
          // ElevatedButton(
          //   onPressed: logOut,
          //   child: Text("Log Out"),
          // ),
          ),
    );
  }
}
