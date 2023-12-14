import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:namer_app/screen/authetication/login.dart';
import 'package:namer_app/screen/home.dart';


class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
      stream: FirebaseAuth.instance.idTokenChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          //land to homepage
          return Home();
        } else {
          //direct to the login page
          return LogIn();
        }
      },
    ));
  }
}
