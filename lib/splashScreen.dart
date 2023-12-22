import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 10), () {
      Navigator.of(context).pushReplacementNamed('/auth');
    });
    return MaterialApp(
      home: Scaffold(
        body: 
        // Text("Splasg screen")
        Image(
          image: AssetImage("assets/images/main_vector.jpg"),
          height: 250,
          
        ),
      ),
    );
  }
}
